import 'package:freezed_annotation/freezed_annotation.dart';

part 'premium_status.freezed.dart';
part 'premium_status.g.dart';

/// クイズモード
enum QuizMode {
  // --- 無料モード ---
  multipleChoice('択一問題', false),
  trueFalse('一問一答', false),
  categoryStudy('カテゴリ別学習', false),

  // --- プレミアムモード ---
  weakness('弱点克服モード', true),
  simulationFull('本番模擬試験（60問）', true),
  simulationHalf('ミニ模擬試験（30問）', true);

  const QuizMode(this.displayName, this.isPremium);

  final String displayName;
  final bool isPremium;

  /// モードの説明
  String get description {
    switch (this) {
      case QuizMode.multipleChoice:
        return 'ランダムに10問出題。基本的な学習に最適。';
      case QuizMode.trueFalse:
        return '○×形式でサクサク学習。通勤時間にも。';
      case QuizMode.categoryStudy:
        return '科目を選んで集中的に学習。';
      case QuizMode.weakness:
        return '正答率の低い分野を重点的に復習。';
      case QuizMode.simulationFull:
        return '本番と同じ60問・180分の模擬試験。';
      case QuizMode.simulationHalf:
        return '30問・90分のハーフサイズ模擬試験。';
    }
  }

  /// モードのアイコン
  String get icon {
    switch (this) {
      case QuizMode.multipleChoice:
        return '📝';
      case QuizMode.trueFalse:
        return '⭕';
      case QuizMode.categoryStudy:
        return '📚';
      case QuizMode.weakness:
        return '💪';
      case QuizMode.simulationFull:
        return '🎯';
      case QuizMode.simulationHalf:
        return '⏱️';
    }
  }
}

/// プレミアム購入種別
enum PremiumPurchaseType {
  none,
  oneTime,
  monthly,
  yearly,
  // 旧バージョン移行用
  legacy;

  String get displayName {
    switch (this) {
      case PremiumPurchaseType.none:
        return '未購入';
      case PremiumPurchaseType.oneTime:
        return '買い切り';
      case PremiumPurchaseType.monthly:
        return '月額プラン';
      case PremiumPurchaseType.yearly:
        return '年額プラン';
      case PremiumPurchaseType.legacy:
        return '旧バージョン移行';
    }
  }
}

/// プレミアム状態モデル
@freezed
class PremiumStatus with _$PremiumStatus {
  const PremiumStatus._();

  const factory PremiumStatus({
    /// プレミアム有効フラグ
    @Default(false) bool isPremium,

    /// 購入種別
    @Default(PremiumPurchaseType.none) PremiumPurchaseType purchaseType,

    /// 有効期限（サブスクの場合）
    DateTime? expiryDate,

    /// 旧バージョンからの移行済みフラグ
    @Default(false) bool isLegacyMigrated,

    /// 購入日時
    DateTime? purchasedAt,
  }) = _PremiumStatus;

  factory PremiumStatus.fromJson(Map<String, dynamic> json) =>
      _$PremiumStatusFromJson(json);

  /// プレミアムが有効かどうか
  bool get isActive {
    if (!isPremium) return false;

    // 買い切りは常に有効
    if (purchaseType == PremiumPurchaseType.oneTime) return true;

    // 旧バージョン移行は常に有効
    if (isLegacyMigrated) return true;

    // サブスクは期限チェック
    if (expiryDate == null) return false;
    return expiryDate!.isAfter(DateTime.now());
  }

  /// 特定のモードにアクセス可能か
  bool canAccess(QuizMode mode) {
    if (!mode.isPremium) return true;
    return isActive;
  }

  /// サブスクの残り日数
  int? get remainingDays {
    if (expiryDate == null) return null;
    if (purchaseType == PremiumPurchaseType.oneTime) return null;

    final diff = expiryDate!.difference(DateTime.now());
    return diff.inDays;
  }
}
