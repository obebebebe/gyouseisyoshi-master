import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_progress.freezed.dart';
part 'user_progress.g.dart';

/// ユーザーの学習進捗モデル
@freezed
class UserProgress with _$UserProgress {
  const factory UserProgress({
    /// 科目ID
    required String licenseType,

    /// 総問題数（その科目で解いた問題数）
    @Default(0) int totalQuestions,

    /// 回答済み問題数
    @Default(0) int answeredQuestions,

    /// 正解数
    @Default(0) int correctAnswers,

    /// 正答率（0.0 - 1.0）
    @Default(0.0) double accuracyRate,

    /// 総学習時間（分）
    @Default(0) int totalStudyTimeMinutes,

    /// 最終学習日時
    DateTime? lastStudiedAt,

    /// 連続学習日数
    @Default(0) int consecutiveDays,

    /// 弱点カテゴリリスト
    @Default([]) List<String> weakCategories,

    /// カテゴリ別統計
    @Default({}) Map<String, CategoryStats> categoryStats,
  }) = _UserProgress;

  factory UserProgress.fromJson(Map<String, dynamic> json) =>
      _$UserProgressFromJson(json);
}

/// カテゴリ別統計
@freezed
class CategoryStats with _$CategoryStats {
  const factory CategoryStats({
    /// 総問題数
    @Default(0) int totalQuestions,

    /// 正解数
    @Default(0) int correctAnswers,

    /// 正答率
    @Default(0.0) double accuracyRate,
  }) = _CategoryStats;

  factory CategoryStats.fromJson(Map<String, dynamic> json) =>
      _$CategoryStatsFromJson(json);
}

/// 全体の学習統計
@freezed
class OverallStats with _$OverallStats {
  const factory OverallStats({
    /// 総回答数
    @Default(0) int totalAnswered,

    /// 総正解数
    @Default(0) int totalCorrect,

    /// 全体正答率
    @Default(0.0) double overallAccuracyRate,

    /// 総学習時間（分）
    @Default(0) int totalStudyTimeMinutes,

    /// 最大連続日数
    @Default(0) int maxConsecutiveDays,

    /// 現在の連続日数
    @Default(0) int currentConsecutiveDays,

    /// 科目別進捗
    @Default({}) Map<String, UserProgress> subjectProgress,
  }) = _OverallStats;

  factory OverallStats.fromJson(Map<String, dynamic> json) =>
      _$OverallStatsFromJson(json);
}
