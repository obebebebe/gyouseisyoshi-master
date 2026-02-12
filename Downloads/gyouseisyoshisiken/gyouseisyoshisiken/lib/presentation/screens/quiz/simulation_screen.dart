import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/colors.dart';
import '../../../data/models/license_type.dart';
import '../../providers/quiz_provider.dart';
import '../../providers/progress_provider.dart';

/// 模擬試験画面
class SimulationScreen extends StatefulWidget {
  final LicenseType licenseType;
  final bool isHalfMode;

  const SimulationScreen({
    super.key,
    required this.licenseType,
    this.isHalfMode = false,
  });

  @override
  State<SimulationScreen> createState() => _SimulationScreenState();
}

class _SimulationScreenState extends State<SimulationScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuizProvider>().loadSimulationQuestions(
            widget.licenseType,
            isHalf: widget.isHalfMode,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final quizProvider = context.watch<QuizProvider>();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldPop = await _showExitDialog(context);
        if (shouldPop && context.mounted) {
          context.read<QuizProvider>().reset();
          context.pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.isHalfMode ? 'ミニ模擬試験' : '本番模擬試験'),
          backgroundColor: widget.licenseType.color,
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () async {
              if (await _showExitDialog(context)) {
                if (context.mounted) {
                  quizProvider.reset();
                  context.pop();
                }
              }
            },
          ),
          actions: [
            // 残り時間
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: _getTimerColor(quizProvider),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.timer, size: 16, color: Colors.white),
                    const SizedBox(width: 4),
                    Text(
                      _formatRemainingTime(quizProvider.remainingSeconds),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        body: _buildBody(quizProvider),
      ),
    );
  }

  Color _getTimerColor(QuizProvider quizProvider) {
    final remaining = quizProvider.remainingSeconds;
    final total = quizProvider.timeLimitSeconds;

    if (remaining <= 300) return AppColors.error; // 5分以下
    if (remaining <= 900) return AppColors.warning; // 15分以下
    return AppColors.success;
  }

  Widget _buildBody(QuizProvider quizProvider) {
    switch (quizProvider.state) {
      case QuizState.loading:
        return const Center(child: CircularProgressIndicator());

      case QuizState.error:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: AppColors.error),
              const SizedBox(height: 16),
              Text(quizProvider.errorMessage ?? 'エラーが発生しました'),
            ],
          ),
        );

      case QuizState.finished:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _onQuizFinished();
        });
        return const Center(child: CircularProgressIndicator());

      default:
        return _buildQuizContent(quizProvider);
    }
  }

  Widget _buildQuizContent(QuizProvider quizProvider) {
    final question = quizProvider.currentQuestion;
    if (question == null) {
      return const Center(child: Text('問題がありません'));
    }

    return Column(
      children: [
        // プログレスと問題一覧
        _buildProgressHeader(quizProvider),

        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 問題番号とカテゴリ
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: widget.licenseType.color,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        '問 ${quizProvider.currentIndex + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Chip(
                      label: Text(
                        question.category,
                        style: const TextStyle(fontSize: 12),
                      ),
                      backgroundColor: Colors.grey[200],
                      padding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // 問題文
                Text(
                  question.question,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 24),

                // 選択肢
                ...List.generate(question.choices.length, (index) {
                  return _buildChoiceButton(
                    index: index,
                    text: question.choices[index],
                    isSelected: quizProvider.currentSelectedAnswer == index,
                    onTap: () => quizProvider.answerQuestion(index),
                  );
                }),
              ],
            ),
          ),
        ),

        // 下部ナビゲーション
        _buildBottomBar(quizProvider),
      ],
    );
  }

  Widget _buildProgressHeader(QuizProvider quizProvider) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.grey[100],
      child: Column(
        children: [
          // プログレスバー
          LinearProgressIndicator(
            value: quizProvider.progress,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(widget.licenseType.color),
          ),
          const SizedBox(height: 8),
          // 問題ボタン一覧（横スクロール）
          SizedBox(
            height: 36,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: quizProvider.totalQuestions,
              itemBuilder: (context, index) {
                final isAnswered = quizProvider.selectedAnswers[index] != null;
                final isCurrent = index == quizProvider.currentIndex;

                return GestureDetector(
                  onTap: () => quizProvider.goToQuestion(index),
                  child: Container(
                    width: 36,
                    height: 36,
                    margin: const EdgeInsets.only(right: 4),
                    decoration: BoxDecoration(
                      color: isCurrent
                          ? widget.licenseType.color
                          : isAnswered
                              ? widget.licenseType.color.withAlpha(76)
                              : Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                      border: isCurrent
                          ? Border.all(
                              color: widget.licenseType.color,
                              width: 2,
                            )
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: isCurrent ? FontWeight.bold : null,
                          color: isCurrent ? Colors.white : null,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChoiceButton({
    required int index,
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final labels = ['A', 'B', 'C', 'D', 'E'];

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: isSelected
            ? AppColors.primary.withAlpha(25)
            : Colors.white,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected ? AppColors.primary : Colors.grey[300]!,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary.withAlpha(51)
                        : Colors.grey[200],
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      labels[index],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isSelected ? AppColors.primary : null,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(text, style: const TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBar(QuizProvider quizProvider) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            // 前の問題
            OutlinedButton.icon(
              onPressed: quizProvider.currentIndex > 0
                  ? () => quizProvider.previousQuestion()
                  : null,
              icon: const Icon(Icons.arrow_back),
              label: const Text('前へ'),
            ),

            const Spacer(),

            // 次の問題 or 提出
            if (quizProvider.currentIndex < quizProvider.totalQuestions - 1)
              ElevatedButton.icon(
                onPressed: () => quizProvider.nextQuestion(),
                icon: const Icon(Icons.arrow_forward),
                label: const Text('次へ'),
              )
            else
              ElevatedButton.icon(
                onPressed: () => _showSubmitDialog(quizProvider),
                icon: const Icon(Icons.check),
                label: const Text('提出する'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.success,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<bool> _showExitDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('試験を中断しますか？'),
        content: const Text('現在の進捗は保存されません。\n本当に中断しますか？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('続ける'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('中断する'),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  Future<void> _showSubmitDialog(QuizProvider quizProvider) async {
    final unanswered =
        quizProvider.selectedAnswers.where((a) => a == null).length;

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('試験を提出しますか？'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('回答済み: ${quizProvider.answeredCount} / ${quizProvider.totalQuestions}'),
            if (unanswered > 0)
              Text(
                '未回答: $unanswered問',
                style: const TextStyle(color: AppColors.warning),
              ),
            const SizedBox(height: 8),
            const Text('提出後は回答を変更できません。'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('戻る'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('提出する'),
          ),
        ],
      ),
    );

    if (result == true) {
      quizProvider.finishQuiz();
    }
  }

  void _onQuizFinished() async {
    final quizProvider = context.read<QuizProvider>();
    final progressProvider = context.read<ProgressProvider>();

    final result = quizProvider.getResult();
    await progressProvider.recordQuizResult(
      licenseType: widget.licenseType.id,
      result: result,
    );

    if (mounted) {
      context.go(
        '/result/simulation/${widget.licenseType.id}?half=${widget.isHalfMode}',
      );
    }
  }

  String _formatRemainingTime(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final secs = seconds % 60;

    if (hours > 0) {
      return '${hours}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }
}
