import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/colors.dart';
import '../../../data/models/license_type.dart';
import '../../../data/models/premium_status.dart';
import '../../providers/purchase_provider.dart';
import '../../providers/progress_provider.dart';

/// 学習メニュー画面
class LearningMenuScreen extends StatelessWidget {
  final LicenseType licenseType;

  const LearningMenuScreen({
    super.key,
    required this.licenseType,
  });

  @override
  Widget build(BuildContext context) {
    final purchaseProvider = context.watch<PurchaseProvider>();
    final progressProvider = context.watch<ProgressProvider>();
    final weakCategories = progressProvider.getWeakCategories(licenseType.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(licenseType.displayName),
        backgroundColor: licenseType.color,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 科目ヘッダー
            _buildHeader(context),
            const SizedBox(height: 24),

            // 無料モード
            const Text(
              '基本学習',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _ModeCard(
              mode: QuizMode.multipleChoice,
              onTap: () => context.push('/quiz/multiple/${licenseType.id}'),
            ),
            _ModeCard(
              mode: QuizMode.trueFalse,
              onTap: () => context.push('/quiz/truefalse/${licenseType.id}'),
            ),
            _ModeCard(
              mode: QuizMode.categoryStudy,
              onTap: () => _showCategoryDialog(context),
            ),

            const SizedBox(height: 24),

            // プレミアムモード
            Row(
              children: [
                const Text(
                  'プレミアム学習',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                if (!purchaseProvider.isPremium)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      gradient: AppColors.premiumGradient,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'PRO',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            _ModeCard(
              mode: QuizMode.weakness,
              isLocked: !purchaseProvider.isPremium,
              subtitle: weakCategories.isNotEmpty
                  ? '弱点: ${weakCategories.join(", ")}'
                  : '弱点カテゴリなし',
              onTap: () {
                if (purchaseProvider.isPremium) {
                  context.push('/quiz/weakness/${licenseType.id}');
                } else {
                  _showPremiumDialog(context);
                }
              },
            ),
            _ModeCard(
              mode: QuizMode.simulationFull,
              isLocked: !purchaseProvider.isPremium,
              onTap: () {
                if (purchaseProvider.isPremium) {
                  context.push('/quiz/simulation/${licenseType.id}');
                } else {
                  _showPremiumDialog(context);
                }
              },
            ),
            _ModeCard(
              mode: QuizMode.simulationHalf,
              isLocked: !purchaseProvider.isPremium,
              onTap: () {
                if (purchaseProvider.isPremium) {
                  context.push('/quiz/simulation/${licenseType.id}?half=true');
                } else {
                  _showPremiumDialog(context);
                }
              },
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: licenseType.color.withAlpha(25),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: licenseType.color.withAlpha(76),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                licenseType.emoji,
                style: const TextStyle(fontSize: 36),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  licenseType.displayName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  licenseType.description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '本番試験: 約${licenseType.examQuestionCount}問出題',
                  style: TextStyle(
                    fontSize: 12,
                    color: licenseType.color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showCategoryDialog(BuildContext context) {
    // カテゴリ選択ダイアログ
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('カテゴリを選択'),
        content: const Text('この機能は後で実装します'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('閉じる'),
          ),
        ],
      ),
    );
  }

  void _showPremiumDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: AppColors.premiumGradient,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.star,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            const Text('プレミアム機能'),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('この機能はプレミアム会員限定です。'),
            SizedBox(height: 16),
            Text(
              'プレミアムに登録すると：',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            _PremiumFeature(text: '弱点克服モード'),
            _PremiumFeature(text: '本番模擬試験'),
            _PremiumFeature(text: 'ミニ模擬試験'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('閉じる'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.push('/purchase');
            },
            child: const Text('詳細を見る'),
          ),
        ],
      ),
    );
  }
}

/// プレミアム機能リストアイテム
class _PremiumFeature extends StatelessWidget {
  final String text;

  const _PremiumFeature({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          const Icon(Icons.check, size: 16, color: AppColors.success),
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }
}

/// モードカード
class _ModeCard extends StatelessWidget {
  final QuizMode mode;
  final bool isLocked;
  final String? subtitle;
  final VoidCallback onTap;

  const _ModeCard({
    required this.mode,
    this.isLocked = false,
    this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: isLocked
                ? Colors.grey[200]
                : AppColors.primary.withAlpha(25),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: isLocked
                ? Icon(Icons.lock, color: Colors.grey[400])
                : Text(mode.icon, style: const TextStyle(fontSize: 24)),
          ),
        ),
        title: Text(
          mode.displayName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isLocked ? Colors.grey : null,
          ),
        ),
        subtitle: Text(
          subtitle ?? mode.description,
          style: TextStyle(
            fontSize: 12,
            color: isLocked ? Colors.grey[400] : Colors.grey[600],
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: isLocked ? Colors.grey[300] : Colors.grey[400],
        ),
      ),
    );
  }
}
