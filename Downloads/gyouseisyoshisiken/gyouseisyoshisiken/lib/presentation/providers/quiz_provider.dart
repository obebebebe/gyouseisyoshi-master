import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../core/constants/app_constants.dart';
import '../../data/models/question.dart';
import '../../data/models/license_type.dart';
import '../../data/models/premium_status.dart';
import '../../data/repositories/question_repository.dart';

/// クイズの状態
enum QuizState {
  initial,
  loading,
  ready,
  answering,
  answered,
  finished,
  error,
}

/// クイズプロバイダー
class QuizProvider extends ChangeNotifier {
  final QuestionRepository _repository = QuestionRepository.instance;

  // 状態
  QuizState _state = QuizState.initial;
  QuizState get state => _state;

  // クイズデータ
  List<Question> _questions = [];
  List<Question> get questions => _questions;

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  Question? get currentQuestion =>
      _questions.isNotEmpty && _currentIndex < _questions.length
          ? _questions[_currentIndex]
          : null;

  // 回答データ
  final List<int?> _selectedAnswers = [];
  List<int?> get selectedAnswers => _selectedAnswers;

  int? get currentSelectedAnswer =>
      _currentIndex < _selectedAnswers.length
          ? _selectedAnswers[_currentIndex]
          : null;

  // タイマー
  Timer? _timer;
  int _elapsedSeconds = 0;
  int get elapsedSeconds => _elapsedSeconds;

  int _timeLimitSeconds = 0;
  int get timeLimitSeconds => _timeLimitSeconds;

  int get remainingSeconds => _timeLimitSeconds > 0
      ? (_timeLimitSeconds - _elapsedSeconds).clamp(0, _timeLimitSeconds)
      : 0;

  bool get isTimeUp => _timeLimitSeconds > 0 && _elapsedSeconds >= _timeLimitSeconds;

  // クイズモード
  QuizMode _quizMode = QuizMode.multipleChoice;
  QuizMode get quizMode => _quizMode;

  // 科目
  LicenseType? _licenseType;
  LicenseType? get licenseType => _licenseType;

  // エラー
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // 進捗
  int get totalQuestions => _questions.length;
  int get answeredCount => _selectedAnswers.where((a) => a != null).length;
  double get progress => totalQuestions > 0 ? answeredCount / totalQuestions : 0.0;

  /// ランダム問題を読み込み（択一問題用）
  Future<void> loadQuestions(LicenseType licenseType) async {
    _setState(QuizState.loading);
    _licenseType = licenseType;
    _quizMode = QuizMode.multipleChoice;
    _timeLimitSeconds = 0;

    try {
      _questions = await _repository.getRandomQuestions(
        licenseType,
        count: AppConstants.defaultQuizCount,
      );
      _initializeAnswers();
      _startTimer();
      _setState(QuizState.ready);
    } catch (e) {
      _errorMessage = e.toString();
      _setState(QuizState.error);
    }
  }

  /// カテゴリ別問題を読み込み
  Future<void> loadCategoryQuestions(
    LicenseType licenseType,
    String category,
  ) async {
    _setState(QuizState.loading);
    _licenseType = licenseType;
    _quizMode = QuizMode.categoryStudy;
    _timeLimitSeconds = 0;

    try {
      _questions = await _repository.getQuestionsByCategory(
        licenseType,
        category,
        count: AppConstants.defaultQuizCount,
      );
      _initializeAnswers();
      _startTimer();
      _setState(QuizState.ready);
    } catch (e) {
      _errorMessage = e.toString();
      _setState(QuizState.error);
    }
  }

  /// 弱点問題を読み込み
  Future<void> loadWeaknessQuestions(
    LicenseType licenseType,
    List<String> weakCategories,
  ) async {
    _setState(QuizState.loading);
    _licenseType = licenseType;
    _quizMode = QuizMode.weakness;
    _timeLimitSeconds = 0;

    try {
      _questions = await _repository.getWeaknessQuestions(
        licenseType,
        weakCategories,
        count: AppConstants.defaultQuizCount,
      );
      _initializeAnswers();
      _startTimer();
      _setState(QuizState.ready);
    } catch (e) {
      _errorMessage = e.toString();
      _setState(QuizState.error);
    }
  }

  /// 模擬試験問題を読み込み
  Future<void> loadSimulationQuestions(
    LicenseType licenseType, {
    bool isHalf = false,
  }) async {
    _setState(QuizState.loading);
    _licenseType = licenseType;
    _quizMode = isHalf ? QuizMode.simulationHalf : QuizMode.simulationFull;

    final questionCount = isHalf
        ? AppConstants.simulationHalfQuestionCount
        : AppConstants.simulationFullQuestionCount;
    _timeLimitSeconds = isHalf
        ? AppConstants.simulationHalfTimeMinutes * 60
        : AppConstants.simulationFullTimeMinutes * 60;

    try {
      _questions = await _repository.getSimulationQuestions(
        licenseType,
        totalCount: questionCount,
      );
      _initializeAnswers();
      _startTimer();
      _setState(QuizState.ready);
    } catch (e) {
      _errorMessage = e.toString();
      _setState(QuizState.error);
    }
  }

  /// 回答を記録
  void answerQuestion(int answerIndex) {
    if (_state != QuizState.ready && _state != QuizState.answering) return;
    if (_currentIndex >= _selectedAnswers.length) return;

    _selectedAnswers[_currentIndex] = answerIndex;
    _setState(QuizState.answered);
    notifyListeners();
  }

  /// 次の問題へ
  void nextQuestion() {
    if (_currentIndex < _questions.length - 1) {
      _currentIndex++;
      _setState(_selectedAnswers[_currentIndex] != null
          ? QuizState.answered
          : QuizState.ready);
    } else {
      finishQuiz();
    }
    notifyListeners();
  }

  /// 前の問題へ
  void previousQuestion() {
    if (_currentIndex > 0) {
      _currentIndex--;
      _setState(_selectedAnswers[_currentIndex] != null
          ? QuizState.answered
          : QuizState.ready);
      notifyListeners();
    }
  }

  /// 特定の問題へジャンプ
  void goToQuestion(int index) {
    if (index >= 0 && index < _questions.length) {
      _currentIndex = index;
      _setState(_selectedAnswers[_currentIndex] != null
          ? QuizState.answered
          : QuizState.ready);
      notifyListeners();
    }
  }

  /// クイズを終了
  void finishQuiz() {
    _stopTimer();
    _setState(QuizState.finished);
  }

  /// 結果を取得
  QuizResult getResult() {
    int correctCount = 0;
    final categoryResults = <String, CategoryResult>{};
    final answerRecords = <AnswerRecord>[];

    for (int i = 0; i < _questions.length; i++) {
      final question = _questions[i];
      final selected = _selectedAnswers[i];
      final isCorrect = selected == question.correctAnswer;

      if (isCorrect) correctCount++;

      // 回答記録
      answerRecords.add(AnswerRecord(
        questionId: question.id,
        selectedAnswer: selected ?? -1,
        correctAnswer: question.correctAnswer,
        isCorrect: isCorrect,
      ));

      // カテゴリ別集計
      final category = question.category;
      final existing = categoryResults[category] ??
          const CategoryResult(total: 0, correct: 0, rate: 0.0);

      categoryResults[category] = CategoryResult(
        total: existing.total + 1,
        correct: existing.correct + (isCorrect ? 1 : 0),
        rate: 0.0, // 後で計算
      );
    }

    // カテゴリ別正答率を計算
    final updatedCategoryResults = categoryResults.map((key, value) {
      return MapEntry(
        key,
        CategoryResult(
          total: value.total,
          correct: value.correct,
          rate: value.total > 0 ? value.correct / value.total : 0.0,
        ),
      );
    });

    final accuracyRate = _questions.isNotEmpty
        ? correctCount / _questions.length
        : 0.0;

    return QuizResult(
      totalQuestions: _questions.length,
      correctAnswers: correctCount,
      accuracyRate: accuracyRate,
      isPassed: accuracyRate >= AppConstants.passingRate,
      elapsedSeconds: _elapsedSeconds,
      categoryResults: updatedCategoryResults,
      answerRecords: answerRecords,
    );
  }

  /// リセット
  void reset() {
    _stopTimer();
    _state = QuizState.initial;
    _questions = [];
    _currentIndex = 0;
    _selectedAnswers.clear();
    _elapsedSeconds = 0;
    _timeLimitSeconds = 0;
    _errorMessage = null;
    notifyListeners();
  }

  // プライベートメソッド

  void _setState(QuizState newState) {
    _state = newState;
    notifyListeners();
  }

  void _initializeAnswers() {
    _selectedAnswers.clear();
    _selectedAnswers.addAll(List<int?>.filled(_questions.length, null));
    _currentIndex = 0;
    _elapsedSeconds = 0;
  }

  void _startTimer() {
    _stopTimer();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _elapsedSeconds++;

      // 時間切れチェック
      if (_timeLimitSeconds > 0 && _elapsedSeconds >= _timeLimitSeconds) {
        finishQuiz();
      }

      notifyListeners();
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }
}
