import '../../core/constants/app_constants.dart';
import '../models/user_progress.dart';
import '../models/question.dart';
import '../datasources/local_storage_service.dart';

/// 学習進捗リポジトリ
class ProgressRepository {
  ProgressRepository._();

  static final ProgressRepository _instance = ProgressRepository._();
  static ProgressRepository get instance => _instance;

  LocalStorageService? _storage;

  /// 初期化
  Future<void> initialize() async {
    _storage = await LocalStorageService.getInstance();
  }

  /// 科目の進捗を取得
  UserProgress getProgress(String licenseType) {
    if (_storage == null) {
      return UserProgress(licenseType: licenseType);
    }
    return _storage!.loadUserProgress(licenseType);
  }

  /// 全科目の進捗を取得
  Map<String, UserProgress> getAllProgress() {
    if (_storage == null) {
      return {};
    }
    return _storage!.loadAllProgress();
  }

  /// クイズ結果を記録
  Future<void> recordQuizResult({
    required String licenseType,
    required int totalQuestions,
    required int correctAnswers,
    required Map<String, CategoryResult> categoryResults,
    required int studyTimeSeconds,
  }) async {
    // 既存の進捗を読み込み
    var progress = _storage!.loadUserProgress(licenseType);

    // カウンターを更新
    final newTotalQuestions = progress.totalQuestions + totalQuestions;
    final newAnsweredQuestions = progress.answeredQuestions + totalQuestions;
    final newCorrectAnswers = progress.correctAnswers + correctAnswers;
    final newAccuracyRate = newAnsweredQuestions > 0
        ? newCorrectAnswers / newAnsweredQuestions
        : 0.0;
    final newStudyTime = progress.totalStudyTimeMinutes + (studyTimeSeconds ~/ 60);

    // カテゴリ別統計を更新
    final newCategoryStats = Map<String, CategoryStats>.from(progress.categoryStats);
    for (final entry in categoryResults.entries) {
      final existing = newCategoryStats[entry.key] ?? const CategoryStats();
      final newTotal = existing.totalQuestions + entry.value.total;
      final newCorrect = existing.correctAnswers + entry.value.correct;
      final newRate = newTotal > 0 ? newCorrect / newTotal : 0.0;

      newCategoryStats[entry.key] = CategoryStats(
        totalQuestions: newTotal,
        correctAnswers: newCorrect,
        accuracyRate: newRate,
      );
    }

    // 弱点カテゴリを更新（正答率60%未満）
    final weakCategories = newCategoryStats.entries
        .where((e) => e.value.accuracyRate < AppConstants.weakCategoryThreshold)
        .map((e) => e.key)
        .toList();

    // 連続日数を計算
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final lastStudy = progress.lastStudiedAt;
    int consecutiveDays = progress.consecutiveDays;

    if (lastStudy != null) {
      final lastStudyDay = DateTime(lastStudy.year, lastStudy.month, lastStudy.day);
      final diff = today.difference(lastStudyDay).inDays;

      if (diff == 0) {
        // 同日 - 維持
      } else if (diff == 1) {
        // 翌日 - +1
        consecutiveDays++;
      } else {
        // それ以外 - リセット
        consecutiveDays = 1;
      }
    } else {
      consecutiveDays = 1;
    }

    // 更新した進捗を作成
    progress = progress.copyWith(
      totalQuestions: newTotalQuestions,
      answeredQuestions: newAnsweredQuestions,
      correctAnswers: newCorrectAnswers,
      accuracyRate: newAccuracyRate,
      totalStudyTimeMinutes: newStudyTime,
      lastStudiedAt: now,
      consecutiveDays: consecutiveDays,
      weakCategories: weakCategories,
      categoryStats: newCategoryStats,
    );

    // 保存
    await _storage!.saveUserProgress(licenseType, progress);
    await _storage!.saveLastStudyDate(now);
    await _storage!.saveConsecutiveDays(consecutiveDays);
  }

  /// 全体統計を取得
  OverallStats getOverallStats() {
    if (_storage == null) {
      return const OverallStats(
        totalAnswered: 0,
        totalCorrect: 0,
        overallAccuracyRate: 0.0,
        totalStudyTimeMinutes: 0,
        maxConsecutiveDays: 0,
        currentConsecutiveDays: 0,
        subjectProgress: {},
      );
    }
    final allProgress = _storage!.loadAllProgress();

    int totalAnswered = 0;
    int totalCorrect = 0;
    int totalStudyTime = 0;
    int maxConsecutive = 0;

    for (final progress in allProgress.values) {
      totalAnswered += progress.answeredQuestions;
      totalCorrect += progress.correctAnswers;
      totalStudyTime += progress.totalStudyTimeMinutes;
      if (progress.consecutiveDays > maxConsecutive) {
        maxConsecutive = progress.consecutiveDays;
      }
    }

    final overallRate = totalAnswered > 0 ? totalCorrect / totalAnswered : 0.0;
    final currentConsecutive = _storage!.loadConsecutiveDays();

    return OverallStats(
      totalAnswered: totalAnswered,
      totalCorrect: totalCorrect,
      overallAccuracyRate: overallRate,
      totalStudyTimeMinutes: totalStudyTime,
      maxConsecutiveDays: maxConsecutive,
      currentConsecutiveDays: currentConsecutive,
      subjectProgress: allProgress.map((k, v) => MapEntry(k, v)),
    );
  }

  /// 弱点カテゴリを取得
  List<String> getWeakCategories(String licenseType) {
    if (_storage == null) {
      return [];
    }
    final progress = _storage!.loadUserProgress(licenseType);
    return progress.weakCategories;
  }

  /// 進捗をリセット（デバッグ用）
  Future<void> resetProgress(String licenseType) async {
    await _storage!.saveUserProgress(
      licenseType,
      UserProgress(licenseType: licenseType),
    );
  }

  /// 全進捗をリセット（デバッグ用）
  Future<void> resetAllProgress() async {
    await _storage!.clearAll();
  }
}
