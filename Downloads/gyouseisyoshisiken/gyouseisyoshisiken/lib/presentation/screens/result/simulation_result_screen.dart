import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/colors.dart';
import '../../../data/models/license_type.dart';
import '../../providers/quiz_provider.dart';

/// 模擬試験結果画面
class SimulationResultScreen extends StatelessWidget {
  final LicenseType licenseType;
  final bool isHalfMode;

  const SimulationResultScreen({
    super.key,
    required this.licenseType,
    this.isHalfMode = false,
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
        appBar: AppBar(
          title: Text(isHalfMode ? 'ミニ模試結果' : '模擬試験結果'),
          backgroundColor: licenseType.color,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // 結果サマリー
              _buildResultSummary(result),
              const SizedBox(height: 24),

              // 本番との比較
              _buildExamComparison(result),
              const SizedBox(height: 24),

              // カテゴリ別成績
              _buildCategoryBreakdown(result),
              const SizedBox(height: 24),

              // アドバイス
              _buildAdvice(result),
              const SizedBox(height: 24),

              // アクションボタン
              _buildActionButtons(context, quizProvider),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultSummary(dynamic result) {
    final isPassed = result.accuracyRate >= AppConstants.passingRate;

    return Card(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: isPassed
                ? [AppColors.success.withAlpha(25), Colors.white]
                : [AppColors.error.withAlpha(25), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // 合否判定
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              decoration: BoxDecoration(
                color: isPassed ? AppColors.success : AppColors.error,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Text(
                isPassed ? '合格ライン達成' : '不合格',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // スコア
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${(result.accuracyRate * 100).toStringAsFixed(1)}',
                  style: TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                    color: isPassed ? AppColors.success : AppColors.error,
                  ),
                ),
                const Text(
                  '%',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            Text(
              '${result.correctAnswers} / ${result.totalQuestions} 問正解',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),

            // 時間
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.timer, color: AppColors.info),
                const SizedBox(width: 8),
                Text(
                  '所要時間: ${_formatTime(result.elapsedSeconds)}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExamComparison(dynamic result) {
    final totalQuestions = isHalfMode
        ? AppConstants.simulationHalfQuestionCount
        : AppConstants.simulationFullQuestionCount;
    final timeLimit = isHalfMode
        ? AppConstants.simulationHalfTimeMinutes
        : AppConstants.simulationFullTimeMinutes;

    final usedTimeMinutes = result.elapsedSeconds / 60;
    final timeEfficiency = (timeLimit - usedTimeMinutes) / timeLimit;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '本番試験との比較',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            _ComparisonRow(
              label: '問題数',
              yourValue: '${result.totalQuestions}問',
              examValue: '$totalQuestions問',
            ),
            _ComparisonRow(
              label: '制限時間',
              yourValue: _formatTime(result.elapsedSeconds),
              examValue: '$timeLimit分',
            ),
            _ComparisonRow(
              label: '合格基準',
              yourValue: '${(result.accuracyRate * 100).toStringAsFixed(1)}%',
              examValue: '${(AppConstants.passingRate * 100).toInt()}%',
              highlight: result.accuracyRate >= AppConstants.passingRate,
            ),

            const SizedBox(height: 12),
            if (timeEfficiency > 0)
              Text(
                '残り時間: ${((timeLimit - usedTimeMinutes)).toStringAsFixed(0)}分 の余裕がありました',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryBreakdown(dynamic result) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '科目別成績',
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
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            entry.key,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              '${entry.value.correct}/${entry.value.total}',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: isWeak
                                    ? AppColors.error.withAlpha(25)
                                    : AppColors.success.withAlpha(25),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '${(rate * 100).toStringAsFixed(0)}%',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isWeak
                                      ? AppColors.error
                                      : AppColors.success,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
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

  Widget _buildAdvice(dynamic result) {
    final weakCategories = result.categoryResults.entries
        .where((e) => e.value.rate < AppConstants.weakCategoryThreshold)
        .map((e) => e.key)
        .toList();

    String advice;
    IconData icon;
    Color color;

    if (result.accuracyRate >= 0.8) {
      advice = '素晴らしい成績です！このペースで学習を続けましょう。';
      icon = Icons.emoji_events;
      color = AppColors.success;
    } else if (result.accuracyRate >= AppConstants.passingRate) {
      advice = '合格ラインは超えましたが、油断は禁物です。弱点分野を補強しましょう。';
      icon = Icons.thumb_up;
      color = AppColors.info;
    } else {
      advice = '弱点分野を重点的に復習しましょう。毎日少しずつ学習を続けることが大切です。';
      icon = Icons.fitness_center;
      color = AppColors.warning;
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color),
                const SizedBox(width: 8),
                const Text(
                  '学習アドバイス',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(advice),
            if (weakCategories.isNotEmpty) ...[
              const SizedBox(height: 12),
              const Text(
                '重点学習が必要な分野:',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: weakCategories.map((cat) {
                  return Chip(
                    label: Text(cat, style: const TextStyle(fontSize: 12)),
                    backgroundColor: AppColors.error.withAlpha(25),
                    side: const BorderSide(color: AppColors.error),
                    visualDensity: VisualDensity.compact,
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, QuizProvider quizProvider) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: () {
            quizProvider.reset();
            context.go('/menu/${licenseType.id}');
          },
          icon: const Icon(Icons.replay),
          label: const Text('別のモードで学習'),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 56),
            backgroundColor: licenseType.color,
          ),
        ),
        const SizedBox(height: 12),
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
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final secs = seconds % 60;

    if (hours > 0) {
      return '$hours時間$minutes分$secs秒';
    }
    return '$minutes分$secs秒';
  }
}

/// 比較行
class _ComparisonRow extends StatelessWidget {
  final String label;
  final String yourValue;
  final String examValue;
  final bool highlight;

  const _ComparisonRow({
    required this.label,
    required this.yourValue,
    required this.examValue,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(label)),
          Expanded(
            flex: 2,
            child: Text(
              yourValue,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: highlight ? AppColors.success : null,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              examValue,
              style: TextStyle(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
