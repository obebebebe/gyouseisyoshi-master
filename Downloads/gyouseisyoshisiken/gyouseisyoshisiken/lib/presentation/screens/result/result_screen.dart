import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/colors.dart';
import '../../../data/models/license_type.dart';
import '../../../data/models/premium_status.dart';
import '../../providers/quiz_provider.dart';

/// 結果画面
class ResultScreen extends StatelessWidget {
  final LicenseType licenseType;
  final QuizMode quizMode;

  const ResultScreen({
    super.key,
    required this.licenseType,
    required this.quizMode,
  });

  @override
  Widget build(BuildContext context) {
    final quizProvider = context.read<QuizProvider>();
    final result = quizProvider.getResult();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        quizProvider.reset();
        context.go('/home');
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 24),

                // 結果ヘッダー
                _buildResultHeader(result),
                const SizedBox(height: 32),

                // スコア詳細
                _buildScoreCard(result),
                const SizedBox(height: 24),

                // カテゴリ別成績
                if (result.categoryResults.isNotEmpty)
                  _buildCategoryResults(result),
                const SizedBox(height: 32),

                // アクションボタン
                _buildActionButtons(context, quizProvider),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResultHeader(dynamic result) {
    final isPassed = result.accuracyRate >= AppConstants.passingRate;

    return Column(
      children: [
        // 結果アイコン
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: isPassed
                ? AppColors.success.withAlpha(25)
                : AppColors.error.withAlpha(25),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              isPassed ? Icons.celebration : Icons.sentiment_dissatisfied,
              size: 64,
              color: isPassed ? AppColors.success : AppColors.error,
            ),
          ),
        ),
        const SizedBox(height: 16),

        // 結果テキスト
        Text(
          isPassed ? '合格ライン達成！' : 'もう少し頑張ろう！',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: isPassed ? AppColors.success : AppColors.error,
          ),
        ),
        const SizedBox(height: 8),

        Text(
          quizMode.displayName,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildScoreCard(dynamic result) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // 正答率の円グラフ風表示
            SizedBox(
              width: 150,
              height: 150,
              child: Stack(
                children: [
                  Center(
                    child: SizedBox(
                      width: 150,
                      height: 150,
                      child: CircularProgressIndicator(
                        value: result.accuracyRate,
                        strokeWidth: 12,
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          result.accuracyRate >= AppConstants.passingRate
                              ? AppColors.success
                              : AppColors.error,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${(result.accuracyRate * 100).toStringAsFixed(0)}%',
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '正答率',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 詳細スコア
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ScoreItem(
                  label: '正解数',
                  value: '${result.correctAnswers}/${result.totalQuestions}',
                  color: AppColors.success,
                ),
                _ScoreItem(
                  label: '合格基準',
                  value: '${(AppConstants.passingRate * 100).toInt()}%',
                  color: AppColors.info,
                ),
                _ScoreItem(
                  label: '所要時間',
                  value: _formatTime(result.elapsedSeconds),
                  color: AppColors.accent,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryResults(dynamic result) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'カテゴリ別成績',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...result.categoryResults.entries.map((entry) {
              final rate = entry.value.rate;
              final isWeak = rate < AppConstants.weakCategoryThreshold;

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            entry.key,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        Text(
                          '${entry.value.correct}/${entry.value.total}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${(rate * 100).toStringAsFixed(0)}%',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isWeak ? AppColors.error : AppColors.success,
                          ),
                        ),
                        if (isWeak) ...[
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.warning,
                            size: 16,
                            color: AppColors.warning,
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: rate,
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          isWeak ? AppColors.error : AppColors.success,
                        ),
                        minHeight: 8,
                      ),
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

  Widget _buildActionButtons(BuildContext context, QuizProvider quizProvider) {
    return Column(
      children: [
        // もう一度挑戦
        ElevatedButton.icon(
          onPressed: () {
            quizProvider.reset();
            context.go('/menu/${licenseType.id}');
          },
          icon: const Icon(Icons.replay),
          label: const Text('もう一度挑戦'),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 56),
            backgroundColor: licenseType.color,
          ),
        ),
        const SizedBox(height: 12),

        // ホームへ戻る
        OutlinedButton.icon(
          onPressed: () {
            quizProvider.reset();
            context.go('/home');
          },
          icon: const Icon(Icons.home),
          label: const Text('ホームへ戻る'),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, 56),
          ),
        ),
      ],
    );
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '$minutes分$secs秒';
  }
}

/// スコアアイテム
class _ScoreItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _ScoreItem({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
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
