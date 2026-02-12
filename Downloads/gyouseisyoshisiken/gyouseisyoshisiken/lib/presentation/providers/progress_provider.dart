import 'package:flutter/foundation.dart';
import '../../data/models/user_progress.dart';
import '../../data/models/question.dart';
import '../../data/repositories/progress_repository.dart';

/// 進捗プロバイダー
class ProgressProvider extends ChangeNotifier {
  final ProgressRepository _repository = ProgressRepository.instance;

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  OverallStats? _overallStats;
  OverallStats? get overallStats => _overallStats;

  Map<String, UserProgress> _subjectProgress = {};
  Map<String, UserProgress> get subjectProgress => _subjectProgress;

  /// 初期化
  Future<void> initialize() async {
    if (_isInitialized) return;

    await _repository.initialize();
    await refresh();
    _isInitialized = true;
  }

  /// データを更新
  Future<void> refresh() async {
    _overallStats = _repository.getOverallStats();
    _subjectProgress = _repository.getAllProgress();
    notifyListeners();
  }

  /// 科目の進捗を取得
  UserProgress getProgress(String licenseType) {
    return _subjectProgress[licenseType] ??
        _repository.getProgress(licenseType);
  }

  /// クイズ結果を記録
  Future<void> recordQuizResult({
    required String licenseType,
    required QuizResult result,
  }) async {
    await _repository.recordQuizResult(
      licenseType: licenseType,
      totalQuestions: result.totalQuestions,
      correctAnswers: result.correctAnswers,
      categoryResults: result.categoryResults,
      studyTimeSeconds: result.elapsedSeconds,
    );

    await refresh();
  }

  /// 弱点カテゴリを取得
  List<String> getWeakCategories(String licenseType) {
    return _repository.getWeakCategories(licenseType);
  }

  /// 全弱点カテゴリを取得
  Map<String, List<String>> getAllWeakCategories() {
    final result = <String, List<String>>{};
    for (final entry in _subjectProgress.entries) {
      if (entry.value.weakCategories.isNotEmpty) {
        result[entry.key] = entry.value.weakCategories;
      }
    }
    return result;
  }

  /// 総学習時間を取得（フォーマット済み）
  String get formattedTotalStudyTime {
    final minutes = _overallStats?.totalStudyTimeMinutes ?? 0;
    if (minutes < 60) {
      return '$minutes分';
    }
    final hours = minutes ~/ 60;
    final remainingMinutes = minutes % 60;
    if (remainingMinutes == 0) {
      return '$hours時間';
    }
    return '$hours時間$remainingMinutes分';
  }

  /// 全体正答率を取得（パーセント表示）
  String get formattedOverallAccuracyRate {
    final rate = _overallStats?.overallAccuracyRate ?? 0.0;
    return '${(rate * 100).toStringAsFixed(1)}%';
  }

  /// 進捗をリセット（デバッグ用）
  Future<void> resetProgress(String licenseType) async {
    await _repository.resetProgress(licenseType);
    await refresh();
  }

  /// 全進捗をリセット（デバッグ用）
  Future<void> resetAllProgress() async {
    await _repository.resetAllProgress();
    _subjectProgress = {};
    _overallStats = null;
    notifyListeners();
  }
}
