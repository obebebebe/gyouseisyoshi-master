import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/colors.dart';
import '../../../data/models/license_type.dart';
import '../../../data/models/premium_status.dart';
import '../../providers/quiz_provider.dart';
import '../../providers/progress_provider.dart';

/// 弱点克服画面
class WeaknessScreen extends StatefulWidget {
  final LicenseType licenseType;

  const WeaknessScreen({
    super.key,
    required this.licenseType,
  });

  @override
  State<WeaknessScreen> createState() => _WeaknessScreenState();
}

class _WeaknessScreenState extends State<WeaknessScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final progressProvider = context.read<ProgressProvider>();
      final weakCategories =
          progressProvider.getWeakCategories(widget.licenseType.id);
      context.read<QuizProvider>().loadWeaknessQuestions(
            widget.licenseType,
            weakCategories,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final quizProvider = context.watch<QuizProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('弱点克服モード'),
        backgroundColor: widget.licenseType.color,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            quizProvider.reset();
            context.pop();
          },
        ),
        actions: [
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
            ],
          ),
        );

      case QuizState.finished:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _onQuizFinished();
        });
        return const Center(child: CircularProgressIndicator());

      default:
        return _QuizContent(
          quizProvider: quizProvider,
          licenseType: widget.licenseType,
        );
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
        '/result/${widget.licenseType.id}',
        extra: QuizMode.weakness,
      );
    }
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }
}

/// クイズコンテンツ
class _QuizContent extends StatelessWidget {
  final QuizProvider quizProvider;
  final LicenseType licenseType;

  const _QuizContent({
    required this.quizProvider,
    required this.licenseType,
  });

  @override
  Widget build(BuildContext context) {
    final question = quizProvider.currentQuestion;
    if (question == null) {
      return const Center(child: Text('問題がありません'));
    }

    final isAnswered = quizProvider.currentSelectedAnswer != null;

    return Column(
      children: [
        LinearProgressIndicator(
          value: quizProvider.progress,
          backgroundColor: Colors.grey[200],
          valueColor: AlwaysStoppedAnimation<Color>(licenseType.color),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: licenseType.color,
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
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  question.question,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 24),
                ...List.generate(question.choices.length, (index) {
                  return _buildChoiceButton(
                    context,
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
                if (isAnswered) ...[
                  const SizedBox(height: 24),
                  _buildExplanation(question, quizProvider),
                ],
              ],
            ),
          ),
        ),
        _buildBottomBar(context, quizProvider, isAnswered),
      ],
    );
  }

  Widget _buildChoiceButton(
    BuildContext context, {
    required int index,
    required String text,
    required bool isSelected,
    required bool isCorrect,
    required bool showResult,
    VoidCallback? onTap,
  }) {
    final labels = ['A', 'B', 'C', 'D', 'E'];

    Color backgroundColor;
    Color borderColor;

    if (showResult) {
      if (isCorrect) {
        backgroundColor = AppColors.success.withAlpha(25);
        borderColor = AppColors.success;
      } else if (isSelected) {
        backgroundColor = AppColors.error.withAlpha(25);
        borderColor = AppColors.error;
      } else {
        backgroundColor = Colors.white;
        borderColor = Colors.grey[300]!;
      }
    } else {
      backgroundColor = isSelected
          ? AppColors.primary.withAlpha(25)
          : Colors.white;
      borderColor = isSelected ? AppColors.primary : Colors.grey[300]!;
    }

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
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(child: Text(text, style: const TextStyle(fontSize: 16))),
              ],
            ),
          ),
        ),
      ),
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
          Text(question.explanation, style: const TextStyle(height: 1.5)),
        ],
      ),
    );
  }

  Widget _buildBottomBar(
    BuildContext context,
    QuizProvider quizProvider,
    bool isAnswered,
  ) {
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
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
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
}
