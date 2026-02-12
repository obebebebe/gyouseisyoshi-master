import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/colors.dart';
import '../../../data/models/license_type.dart';
import '../../providers/progress_provider.dart';
import '../../providers/purchase_provider.dart';

/// ホーム画面
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          _HomeContent(),
          _StatsPlaceholder(),
          _SettingsPlaceholder(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 1) {
            context.push('/stats');
          } else if (index == 2) {
            context.push('/settings');
          } else {
            setState(() => _currentIndex = index);
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'ホーム',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: '統計',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '設定',
          ),
        ],
      ),
    );
  }
}

/// ホームコンテンツ
class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    final progressProvider = context.watch<ProgressProvider>();
    final purchaseProvider = context.watch<PurchaseProvider>();

    return CustomScrollView(
      slivers: [
        // AppBar
        SliverAppBar(
          expandedHeight: 180,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: const Text(
              AppConstants.appName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    offset: Offset(0, 1),
                    blurRadius: 3,
                    color: Colors.black45,
                  ),
                ],
              ),
            ),
            background: Container(
              decoration: const BoxDecoration(
                gradient: AppColors.primaryGradient,
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          if (purchaseProvider.isPremium) ...[
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                gradient: AppColors.premiumGradient,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'Premium',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          actions: [
            if (!purchaseProvider.isPremium)
              IconButton(
                icon: const Icon(Icons.workspace_premium),
                onPressed: () => context.push('/purchase'),
                tooltip: 'プレミアムにアップグレード',
              ),
          ],
        ),

        // 学習サマリー
        SliverToBoxAdapter(
          child: _buildStudySummary(context, progressProvider),
        ),

        // 科目選択ヘッダー
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
            child: Text(
              '科目を選択',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        // 科目カード一覧
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final licenseType = LicenseType.values[index];
                final progress = progressProvider.getProgress(licenseType.id);

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _SubjectCard(
                    licenseType: licenseType,
                    accuracyRate: progress.accuracyRate,
                    answeredCount: progress.answeredQuestions,
                    onTap: () => context.push('/menu/${licenseType.id}'),
                  ),
                );
              },
              childCount: LicenseType.values.length,
            ),
          ),
        ),

        // 下部余白
        const SliverToBoxAdapter(
          child: SizedBox(height: 24),
        ),
      ],
    );
  }

  Widget _buildStudySummary(
    BuildContext context,
    ProgressProvider progressProvider,
  ) {
    final stats = progressProvider.overallStats;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '学習サマリー',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _SummaryItem(
                  icon: Icons.check_circle,
                  iconColor: AppColors.success,
                  label: '正答率',
                  value: progressProvider.formattedOverallAccuracyRate,
                ),
              ),
              Expanded(
                child: _SummaryItem(
                  icon: Icons.timer,
                  iconColor: AppColors.info,
                  label: '学習時間',
                  value: progressProvider.formattedTotalStudyTime,
                ),
              ),
              Expanded(
                child: _SummaryItem(
                  icon: Icons.local_fire_department,
                  iconColor: AppColors.accent,
                  label: '連続日数',
                  value: '${stats?.currentConsecutiveDays ?? 0}日',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// サマリーアイテム
class _SummaryItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  const _SummaryItem({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: iconColor, size: 28),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
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

/// 科目カード
class _SubjectCard extends StatelessWidget {
  final LicenseType licenseType;
  final double accuracyRate;
  final int answeredCount;
  final VoidCallback onTap;

  const _SubjectCard({
    required this.licenseType,
    required this.accuracyRate,
    required this.answeredCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // アイコン
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: licenseType.color.withAlpha(25),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    licenseType.emoji,
                    style: const TextStyle(fontSize: 28),
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // テキスト
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      licenseType.displayName,
                      style: const TextStyle(
                        fontSize: 16,
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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    // 進捗バー
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: accuracyRate,
                              backgroundColor: Colors.grey[200],
                              valueColor: AlwaysStoppedAnimation<Color>(
                                licenseType.color,
                              ),
                              minHeight: 6,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${(accuracyRate * 100).toStringAsFixed(0)}%',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: licenseType.color,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // 矢印
              Icon(
                Icons.chevron_right,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// プレースホルダー（実際の画面は別ファイル）
class _StatsPlaceholder extends StatelessWidget {
  const _StatsPlaceholder();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('統計'));
  }
}

class _SettingsPlaceholder extends StatelessWidget {
  const _SettingsPlaceholder();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('設定'));
  }
}
