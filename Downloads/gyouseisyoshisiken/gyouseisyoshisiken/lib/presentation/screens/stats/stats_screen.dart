import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/colors.dart';
import '../../../data/models/license_type.dart';
import '../../providers/progress_provider.dart';

/// 統計画面
class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final progressProvider = context.watch<ProgressProvider>();
    final stats = progressProvider.overallStats;

    return Scaffold(
      appBar: AppBar(
        title: const Text('学習統計'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 全体サマリー
            _buildOverallSummary(progressProvider),
            const SizedBox(height: 24),

            // 連続学習
            _buildStreakCard(stats),
            const SizedBox(height: 24),

            // 科目別進捗
            const Text(
              '科目別進捗',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...LicenseType.values.map((type) {
              final progress = progressProvider.getProgress(type.id);
              return _SubjectProgressCard(
                licenseType: type,
                progress: progress,
              );
            }),

            // 弱点カテゴリ
            const SizedBox(height: 24),
            _buildWeakCategories(progressProvider),
          ],
        ),
      ),
    );
  }

  Widget _buildOverallSummary(ProgressProvider provider) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '全体サマリー',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _StatItem(
                    icon: Icons.check_circle,
                    iconColor: AppColors.success,
                    label: '総回答数',
                    value: '${provider.overallStats?.totalAnswered ?? 0}問',
                  ),
                ),
                Expanded(
                  child: _StatItem(
                    icon: Icons.percent,
                    iconColor: AppColors.primary,
                    label: '全体正答率',
                    value: provider.formattedOverallAccuracyRate,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _StatItem(
                    icon: Icons.timer,
                    iconColor: AppColors.info,
                    label: '総学習時間',
                    value: provider.formattedTotalStudyTime,
                  ),
                ),
                Expanded(
                  child: _StatItem(
                    icon: Icons.local_fire_department,
                    iconColor: AppColors.accent,
                    label: '連続日数',
                    value: '${provider.overallStats?.currentConsecutiveDays ?? 0}日',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStreakCard(dynamic stats) {
    final current = stats?.currentConsecutiveDays ?? 0;
    final max = stats?.maxConsecutiveDays ?? 0;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: AppColors.accent.withAlpha(25),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Icon(
                  Icons.local_fire_department,
                  size: 36,
                  color: AppColors.accent,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '連続学習記録',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(color: AppColors.textPrimary),
                      children: [
                        TextSpan(
                          text: '$current',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: AppColors.accent,
                          ),
                        ),
                        const TextSpan(
                          text: ' 日継続中',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '最高記録: $max日',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeakCategories(ProgressProvider provider) {
    final weakCategories = provider.getAllWeakCategories();

    if (weakCategories.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Icon(Icons.check_circle, color: AppColors.success),
              const SizedBox(width: 12),
              const Text('現在、弱点カテゴリはありません'),
            ],
          ),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.warning, color: AppColors.warning),
                const SizedBox(width: 8),
                const Text(
                  '弱点カテゴリ（正答率60%未満）',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...weakCategories.entries.map((entry) {
              final licenseType = LicenseType.fromId(entry.key);
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      licenseType?.displayName ?? entry.key,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 4),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: entry.value.map((cat) {
                        return Chip(
                          label: Text(cat, style: const TextStyle(fontSize: 12)),
                          backgroundColor: AppColors.error.withAlpha(25),
                          side: const BorderSide(color: AppColors.error),
                          visualDensity: VisualDensity.compact,
                        );
                      }).toList(),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

/// 統計アイテム
class _StatItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  const _StatItem({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: iconColor, size: 32),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}

/// 科目別進捗カード
class _SubjectProgressCard extends StatelessWidget {
  final LicenseType licenseType;
  final dynamic progress;

  const _SubjectProgressCard({
    required this.licenseType,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final hasProgress = progress.answeredQuestions > 0;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // アイコン
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: licenseType.color.withAlpha(25),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  licenseType.emoji,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ),
            const SizedBox(width: 12),

            // 情報
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    licenseType.displayName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  if (hasProgress) ...[
                    Row(
                      children: [
                        Text(
                          '正答率: ${(progress.accuracyRate * 100).toStringAsFixed(0)}%',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          '回答数: ${progress.answeredQuestions}問',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: progress.accuracyRate,
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          licenseType.color,
                        ),
                        minHeight: 6,
                      ),
                    ),
                  ] else
                    Text(
                      'まだ学習を始めていません',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[400],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
