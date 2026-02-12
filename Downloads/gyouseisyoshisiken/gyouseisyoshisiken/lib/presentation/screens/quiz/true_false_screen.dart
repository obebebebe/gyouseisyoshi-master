import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/colors.dart';
import '../../../data/models/license_type.dart';
import '../../../data/models/premium_status.dart';
import '../../providers/quiz_provider.dart';
import '../../providers/progress_provider.dart';

/// 一問一答画面（簡易版として択一と同じ構造）
class TrueFalseScreen extends StatefulWidget {
  final LicenseType licenseType;

  const TrueFalseScreen({
    super.key,
    required this.licenseType,
  });

  @override
  State<TrueFalseScreen> createState() => _TrueFalseScreenState();
}

class _TrueFalseScreenState extends State<TrueFalseScreen> {
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('一問一答'),
        backgroundColor: widget.licenseType.color,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            quizProvider.reset();
            context.pop();
          },
        ),
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
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // 問題番号
                Text(
                  '${quizProvider.currentIndex + 1} / ${quizProvider.totalQuestions}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 24),

                // 問題文
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Text(
                        question.question,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          height: 1.6,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),

                // 回答結果
                if (isAnswered) ...[
                  _buildResult(question, quizProvider),
                  const SizedBox(height: 24),
                ],

                // ○×ボタン or 次へボタン
                if (isAnswered)
                  ElevatedButton(
                    onPressed: () {
                      if (quizProvider.currentIndex <
                          quizProvider.totalQuestions - 1) {
                        quizProvider.nextQuestion();
                      } else {
                        quizProvider.finishQuiz();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 56),
                    ),
                    child: Text(
                      quizProvider.currentIndex <
                              quizProvider.totalQuestions - 1
                          ? '次の問題へ'
                          : '結果を見る',
                    ),
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: _buildAnswerButton(
                          context,
                          isTrue: false,
                          onTap: () => quizProvider.answerQuestion(1),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildAnswerButton(
                          context,
                          isTrue: true,
                          onTap: () => quizProvider.answerQuestion(0),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnswerButton(
    BuildContext context, {
    required bool isTrue,
    required VoidCallback onTap,
  }) {
    return Material(
      color: isTrue ? AppColors.success.withAlpha(25) : AppColors.error.withAlpha(25),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            border: Border.all(
              color: isTrue ? AppColors.success : AppColors.error,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              isTrue ? '○' : '×',
              style: TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.bold,
                color: isTrue ? AppColors.success : AppColors.error,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResult(dynamic question, QuizProvider quizProvider) {
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
        children: [
          Icon(
            isCorrect ? Icons.check_circle : Icons.cancel,
            size: 48,
            color: isCorrect ? AppColors.success : AppColors.error,
          ),
          const SizedBox(height: 8),
          Text(
            isCorrect ? '正解！' : '不正解',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isCorrect ? AppColors.success : AppColors.error,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            question.explanation,
            style: const TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
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
        extra: QuizMode.trueFalse,
      );
    }
  }
}
