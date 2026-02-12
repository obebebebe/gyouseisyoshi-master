import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/colors.dart';
import '../../providers/purchase_provider.dart';

/// 購入画面
class PurchaseScreen extends StatelessWidget {
  const PurchaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final purchaseProvider = context.watch<PurchaseProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('プレミアム'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: purchaseProvider.isPremium
          ? _buildAlreadyPremium(context, purchaseProvider)
          : _buildPurchaseContent(context, purchaseProvider),
    );
  }

  Widget _buildAlreadyPremium(
    BuildContext context,
    PurchaseProvider provider,
  ) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFFFD700),
            Color(0xFFFFA000),
          ],
        ),
      ),
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.workspace_premium,
                  size: 100,
                  color: Colors.white,
                ),
                const SizedBox(height: 24),
                const Text(
                  'プレミアム会員です',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  provider.premiumStatus.purchaseType.displayName,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                if (provider.premiumStatus.remainingDays != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    '残り${provider.premiumStatus.remainingDays}日',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
                const SizedBox(height: 48),
                const Text(
                  '全てのプレミアム機能が\n利用可能です',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),
                _PremiumFeatureList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPurchaseContent(
    BuildContext context,
    PurchaseProvider provider,
  ) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // ヘッダー
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 100, 24, 32),
            decoration: const BoxDecoration(
              gradient: AppColors.premiumGradient,
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.workspace_premium,
                  size: 80,
                  color: Colors.white,
                ),
                const SizedBox(height: 16),
                const Text(
                  'プレミアムに\nアップグレード',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '全ての機能を解放して合格を目指そう',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          // プレミアム機能
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'プレミアム機能',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _PremiumFeatureList(),
                const SizedBox(height: 32),

                // 料金プラン
                const Text(
                  '料金プラン',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                // 買い切り（おすすめ）
                _PlanCard(
                  title: '買い切り',
                  price: '¥1,980',
                  description: '一度の購入で永久に利用可能',
                  isRecommended: true,
                  onTap: () => _handlePurchase(context, provider, 'oneTime'),
                ),
                const SizedBox(height: 12),

                // 年額
                _PlanCard(
                  title: '年額プラン',
                  price: '¥3,980/年',
                  description: '月額より約31%お得',
                  onTap: () => _handlePurchase(context, provider, 'yearly'),
                ),
                const SizedBox(height: 12),

                // 月額
                _PlanCard(
                  title: '月額プラン',
                  price: '¥480/月',
                  description: 'いつでも解約可能',
                  onTap: () => _handlePurchase(context, provider, 'monthly'),
                ),

                const SizedBox(height: 24),

                // 復元ボタン
                Center(
                  child: TextButton(
                    onPressed: () => _handleRestore(context, provider),
                    child: const Text('以前の購入を復元'),
                  ),
                ),

                const SizedBox(height: 16),

                // 注意事項
                Text(
                  '※ 定期購入は自動更新されます。解約は各ストアの設定から行ってください。',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handlePurchase(
    BuildContext context,
    PurchaseProvider provider,
    String planType,
  ) {
    // 実際の課金処理（商品がロードされている場合）
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('課金処理を開始します...（デモ版では実際の課金は行われません）'),
      ),
    );

    // デモ用: デバッグモードでプレミアムを有効化
    provider.debugTogglePremium();
  }

  void _handleRestore(BuildContext context, PurchaseProvider provider) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('購入を復元中...')),
    );

    await provider.restorePurchases();

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            provider.isPremium ? '購入を復元しました' : '復元可能な購入が見つかりませんでした',
          ),
        ),
      );
    }
  }
}

/// プレミアム機能リスト
class _PremiumFeatureList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _FeatureItem(
          icon: Icons.fitness_center,
          title: '弱点克服モード',
          description: '苦手な分野を集中的に学習',
        ),
        _FeatureItem(
          icon: Icons.timer,
          title: '本番模擬試験',
          description: '60問・180分の本番形式',
        ),
        _FeatureItem(
          icon: Icons.speed,
          title: 'ミニ模擬試験',
          description: '30問・90分のハーフサイズ',
        ),
        _FeatureItem(
          icon: Icons.block,
          title: '広告なし',
          description: '快適な学習環境',
        ),
      ],
    );
  }
}

/// 機能アイテム
class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primary.withAlpha(25),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.check_circle,
            color: AppColors.success,
          ),
        ],
      ),
    );
  }
}

/// プランカード
class _PlanCard extends StatelessWidget {
  final String title;
  final String price;
  final String description;
  final bool isRecommended;
  final VoidCallback onTap;

  const _PlanCard({
    required this.title,
    required this.price,
    required this.description,
    this.isRecommended = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isRecommended ? 4 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isRecommended ? AppColors.primary : Colors.grey[300]!,
          width: isRecommended ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        if (isRecommended) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'おすすめ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                price,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isRecommended ? AppColors.primary : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
