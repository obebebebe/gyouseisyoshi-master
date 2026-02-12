import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import '../../core/constants/app_constants.dart';
import '../../data/models/premium_status.dart';
import '../../data/datasources/local_storage_service.dart';

/// 課金状態
enum PurchaseState {
  initial,
  loading,
  ready,
  purchasing,
  restoring,
  error,
}

/// 課金プロバイダー
class PurchaseProvider extends ChangeNotifier {
  final InAppPurchase _iap = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>>? _subscription;

  LocalStorageService? _storage;

  // 状態
  PurchaseState _state = PurchaseState.initial;
  PurchaseState get state => _state;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // プレミアム状態
  PremiumStatus _premiumStatus = const PremiumStatus();
  PremiumStatus get premiumStatus => _premiumStatus;

  bool get isPremium => _premiumStatus.isActive;

  // 商品情報
  List<ProductDetails> _products = [];
  List<ProductDetails> get products => _products;

  // 商品ID一覧
  static const Set<String> _productIds = {
    AppConstants.productIdMonthly,
    AppConstants.productIdYearly,
    AppConstants.productIdPremium,
  };

  /// 初期化
  Future<void> initialize() async {
    _setState(PurchaseState.loading);

    try {
      _storage = await LocalStorageService.getInstance();

      // 保存されたプレミアム状態を読み込み
      _premiumStatus = _storage!.loadPremiumStatus();

      // IAP が利用可能かチェック
      final available = await _iap.isAvailable();
      if (!available) {
        _setState(PurchaseState.ready);
        return;
      }

      // 購入ストリームを監視
      _subscription = _iap.purchaseStream.listen(
        _handlePurchaseUpdates,
        onError: (error) {
          _errorMessage = error.toString();
          _setState(PurchaseState.error);
        },
      );

      // 商品情報を取得
      await _loadProducts();

      _setState(PurchaseState.ready);
    } catch (e) {
      _errorMessage = e.toString();
      _setState(PurchaseState.error);
    }
  }

  /// 商品情報を読み込み
  Future<void> _loadProducts() async {
    final response = await _iap.queryProductDetails(_productIds);

    if (response.notFoundIDs.isNotEmpty) {
      print('Not found products: ${response.notFoundIDs}');
    }

    _products = response.productDetails;
    notifyListeners();
  }

  /// 購入処理
  Future<void> purchase(ProductDetails product) async {
    _setState(PurchaseState.purchasing);

    try {
      final purchaseParam = PurchaseParam(productDetails: product);

      // サブスクか買い切りかで処理を分岐
      if (product.id == AppConstants.productIdPremium) {
        await _iap.buyNonConsumable(purchaseParam: purchaseParam);
      } else {
        await _iap.buyNonConsumable(purchaseParam: purchaseParam);
      }
    } catch (e) {
      _errorMessage = e.toString();
      _setState(PurchaseState.error);
    }
  }

  /// 購入復元
  Future<void> restorePurchases() async {
    _setState(PurchaseState.restoring);

    try {
      await _iap.restorePurchases();
      _setState(PurchaseState.ready);
    } catch (e) {
      _errorMessage = e.toString();
      _setState(PurchaseState.error);
    }
  }

  /// 購入更新ハンドラ
  void _handlePurchaseUpdates(List<PurchaseDetails> purchases) async {
    for (final purchase in purchases) {
      switch (purchase.status) {
        case PurchaseStatus.pending:
          // 処理中
          break;

        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          // 購入完了または復元
          await _verifyAndDeliverPurchase(purchase);
          break;

        case PurchaseStatus.error:
          _errorMessage = purchase.error?.message ?? '購入エラーが発生しました';
          _setState(PurchaseState.error);
          break;

        case PurchaseStatus.canceled:
          _setState(PurchaseState.ready);
          break;
      }

      // 保留中の購入を完了
      if (purchase.pendingCompletePurchase) {
        await _iap.completePurchase(purchase);
      }
    }
  }

  /// 購入検証と配信
  Future<void> _verifyAndDeliverPurchase(PurchaseDetails purchase) async {
    // 本番環境では、サーバーサイドでレシート検証を行うべき
    // ここでは簡易的にローカルで処理

    PremiumPurchaseType purchaseType;
    DateTime? expiryDate;

    switch (purchase.productID) {
      case AppConstants.productIdMonthly:
        purchaseType = PremiumPurchaseType.monthly;
        expiryDate = DateTime.now().add(const Duration(days: 30));
        break;
      case AppConstants.productIdYearly:
        purchaseType = PremiumPurchaseType.yearly;
        expiryDate = DateTime.now().add(const Duration(days: 365));
        break;
      case AppConstants.productIdPremium:
        purchaseType = PremiumPurchaseType.oneTime;
        expiryDate = null;
        break;
      default:
        return;
    }

    _premiumStatus = PremiumStatus(
      isPremium: true,
      purchaseType: purchaseType,
      expiryDate: expiryDate,
      purchasedAt: DateTime.now(),
    );

    await _storage!.savePremiumStatus(_premiumStatus);
    _setState(PurchaseState.ready);
  }

  /// 特定モードへのアクセス可否
  bool canAccess(QuizMode mode) {
    return _premiumStatus.canAccess(mode);
  }

  /// デバッグ用: プレミアム状態を切り替え
  Future<void> debugTogglePremium() async {
    if (!kDebugMode) return;

    if (_premiumStatus.isPremium) {
      _premiumStatus = const PremiumStatus();
    } else {
      _premiumStatus = PremiumStatus(
        isPremium: true,
        purchaseType: PremiumPurchaseType.oneTime,
        purchasedAt: DateTime.now(),
      );
    }

    await _storage!.savePremiumStatus(_premiumStatus);
    notifyListeners();
  }

  /// デバッグ用: プレミアム状態をリセット
  Future<void> debugResetPremium() async {
    if (!kDebugMode) return;

    _premiumStatus = const PremiumStatus();
    await _storage!.savePremiumStatus(_premiumStatus);
    notifyListeners();
  }

  void _setState(PurchaseState newState) {
    _state = newState;
    notifyListeners();
  }

  /// 月額商品を取得
  ProductDetails? get monthlyProduct {
    try {
      return _products.firstWhere((p) => p.id == AppConstants.productIdMonthly);
    } catch (_) {
      return null;
    }
  }

  /// 年額商品を取得
  ProductDetails? get yearlyProduct {
    try {
      return _products.firstWhere((p) => p.id == AppConstants.productIdYearly);
    } catch (_) {
      return null;
    }
  }

  /// 買い切り商品を取得
  ProductDetails? get oneTimeProduct {
    try {
      return _products.firstWhere((p) => p.id == AppConstants.productIdPremium);
    } catch (_) {
      return null;
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
