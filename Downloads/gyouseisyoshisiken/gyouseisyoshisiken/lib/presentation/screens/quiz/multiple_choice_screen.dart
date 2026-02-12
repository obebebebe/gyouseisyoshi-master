import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/colors.dart';
import '../../../data/models/license_type.dart';
import '../../../data/models/premium_status.dart';
import '../../providers/quiz_provider.dart';
import '../../providers/progress_provider.dart';

/// 択一問題画面
class MultipleChoiceScreen extends StatefulWidget {
  final LicenseType licenseType;

  const MultipleChoiceScreen({
    super.key,
    required this.licenseType,
  });

  @override
  State<MultipleChoiceScreen> createState() => _MultipleChoiceScreenState();
}

class _MultipleChoiceScreenState extends State<MultipleChoiceScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuizProvider>().loadQuestions(widget.licenseType);
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
          quizProvider.reset();
          context.pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.licenseType.displayName),
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
            // 経過時間
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Text(
                  _formatTime(quizProvider.elapsedSeconds),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
        body: _buildBody(quizProvider),
      ),
    );
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
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () =>
                    quizProvider.loadQuestions(widget.licenseType),
                child: const Text('再読み込み'),
              ),
            ],
          ),
        );

      case QuizState.finished:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _onQuizFinished();
        });
        return const Center(child: CircularProgressIndicator());

      case QuizState.ready:
      case QuizState.answering:
      case QuizState.answered:
        return _buildQuizContent(quizProvider);

      default:
        return const Center(child: CircularProgressIndicator());
    }
  }

  Widget _buildQuizContent(QuizProvider quizProvider) {
    final question = quizProvider.currentQuestion;
    if (question == null) {
      return const Center(child: Text('問題がありません'));
    }

    final isAnswered = quizProvider.currentSelectedAnswer != null;

    return Column(
      children: [
        // プログレスバー
        LinearProgressIndicator(
          value: quizProvider.progress,
          backgroundColor: Colors.grey[200],
          valueColor: AlwaysStoppedAnimation<Color>(widget.licenseType.color),
        ),

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
                        '問 ${quizProvider.currentIndex + 1} / ${quizProvider.totalQuestions}',
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
                  return _ChoiceButton(
                    index: index,
                    text: question.choices[index],
                    isSelected: quizProvider.currentSelectedAnswer == index,
                    isCorrect: question.correctAnswer == index,
                    showResult: isAnswered,
                    onTap: isAnswered
                        ? null
                        : () => quizProvider.answerQuestion(index),
                  );
                }),

                // 解説（回答後）
                if (isAnswered) ...[
                  const SizedBox(height: 24),
                  _buildExplanation(question, quizProvider),
                ],
              ],
            ),
          ),
        ),

        // 下部ボタン
        _buildBottomBar(quizProvider, isAnswered),
      ],
    );
  }

  Widget _buildExplanation(dynamic question, QuizProvider quizProvider) {
    final isCorrect =
        quizProvider.currentSelectedAnswer == question.correctAnswer;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isCorrect
            ? AppColors.success.withAlpha(25)
            : AppColors.error.withAlpha(25),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isCorrect ? AppColors.success : AppColors.error,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isCorrect ? Icons.check_circle : Icons.cancel,
                color: isCorrect ? AppColors.success : AppColors.error,
              ),
              const SizedBox(width: 8),
              Text(
                isCorrect ? '正解！' : '不正解',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isCorrect ? AppColors.success : AppColors.error,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            '解説',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            question.explanation,
            style: const TextStyle(height: 1.5),
          ),
          if (question.reference != null && question.reference!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              '参照: ${question.reference}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBottomBar(QuizProvider quizProvider, bool isAnswered) {
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
            if (quizProvider.currentIndex > 0)
              OutlinedButton.icon(
                onPressed: () => quizProvider.previousQuestion(),
                icon: const Icon(Icons.arrow_back),
                label: const Text('前へ'),
              )
            else
              const SizedBox(width: 100),

            const Spacer(),

            // 次の問題 / 結果を見る
            if (isAnswered)
              ElevatedButton.icon(
                onPressed: () {
                  if (quizProvider.currentIndex <
                      quizProvider.totalQuestions - 1) {
                    quizProvider.nextQuestion();
                  } else {
                    quizProvider.finishQuiz();
                  }
                },
                icon: Icon(
                  quizProvider.currentIndex < quizProvider.totalQuestions - 1
                      ? Icons.arrow_forward
                      : Icons.check,
                ),
                label: Text(
                  quizProvider.currentIndex < quizProvider.totalQuestions - 1
                      ? '次へ'
                      : '結果を見る',
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
        title: const Text('学習を中断しますか？'),
        content: const Text('現在の進捗は保存されません。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('続ける'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('中断する'),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  void _onQuizFinished() async {
    final quizProvider = context.read<QuizProvider>();
    final progressProvider = context.read<ProgressProvider>();

    // 結果を記録
    final result = quizProvider.getResult();
    await progressProvider.recordQuizResult(
      licenseType: widget.licenseType.id,
      result: result,
    );

    // 結果画面へ遷移
    if (mounted) {
      context.go(
        '/result/${widget.licenseType.id}',
        extra: QuizMode.multipleChoice,
      );
    }
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }
}

/// 選択肢ボタン
class _ChoiceButton extends StatelessWidget {
  final int index;
  final String text;
  final bool isSelected;
  final bool isCorrect;
  final bool showResult;
  final VoidCallback? onTap;

  const _ChoiceButton({
    required this.index,
    required this.text,
    required this.isSelected,
    required this.isCorrect,
    required this.showResult,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color borderColor;
    Color textColor;

    if (showResult) {
      if (isCorrect) {
        backgroundColor = AppColors.success.withAlpha(25);
        borderColor = AppColors.success;
        textColor = AppColors.success;
      } else if (isSelected) {
        backgroundColor = AppColors.error.withAlpha(25);
        borderColor = AppColors.error;
        textColor = AppColors.error;
      } else {
        backgroundColor = Colors.white;
        borderColor = Colors.grey[300]!;
        textColor = Colors.grey;
      }
    } else {
      if (isSelected) {
        backgroundColor = AppColors.primary.withAlpha(25);
        borderColor = AppColors.primary;
        textColor = AppColors.primary;
      } else {
        backgroundColor = Colors.white;
        borderColor = Colors.grey[300]!;
        textColor = AppColors.textPrimary;
      }
    }

    final labels = ['A', 'B', 'C', 'D', 'E'];

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: borderColor, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: borderColor.withAlpha(51),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      labels[index],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 16,
                      color: textColor,
                    ),
                  ),
                ),
                if (showResult && isCorrect)
                  const Icon(Icons.check_circle, color: AppColors.success)
                else if (showResult && isSelected && !isCorrect)
                  const Icon(Icons.cancel, color: AppColors.error),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
