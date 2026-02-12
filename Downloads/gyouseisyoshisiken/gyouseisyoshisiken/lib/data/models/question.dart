import 'package:freezed_annotation/freezed_annotation.dart';

part 'question.freezed.dart';
part 'question.g.dart';

/// 問題モデル
@freezed
class Question with _$Question {
  const factory Question({
    /// 問題ID（例: "constitution_001"）
    required String id,

    /// 科目カテゴリ（例: "憲法"）
    required String category,

    /// 問題文
    required String question,

    /// 選択肢リスト（5択）
    required List<String> choices,

    /// 正解のインデックス（0始まり）
    @JsonKey(name: 'correct_answer') required int correctAnswer,

    /// 解説文
    required String explanation,

    /// 法令参照（任意）
    String? reference,

    /// 難易度（1: 易, 2: 普通, 3: 難）
    @Default(1) int difficulty,

    /// タグ（検索用）
    @Default([]) List<String> tags,

    /// 年度（過去問の場合）
    int? year,
  }) = _Question;

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
}

/// 問題データのルートモデル
@freezed
class QuestionData with _$QuestionData {
  const factory QuestionData({
    /// 科目ID
    @JsonKey(name: 'license_type') required String licenseType,

    /// データバージョン
    required String version,

    /// 最終更新日
    @JsonKey(name: 'last_updated') required String lastUpdated,

    /// 問題リスト
    required List<Question> questions,
  }) = _QuestionData;

  factory QuestionData.fromJson(Map<String, dynamic> json) =>
      _$QuestionDataFromJson(json);
}

/// クイズ結果モデル
@freezed
class QuizResult with _$QuizResult {
  const factory QuizResult({
    /// 総問題数
    required int totalQuestions,

    /// 正解数
    required int correctAnswers,

    /// 正答率
    required double accuracyRate,

    /// 合格判定
    required bool isPassed,

    /// 所要時間（秒）
    required int elapsedSeconds,

    /// カテゴリ別成績
    required Map<String, CategoryResult> categoryResults,

    /// 回答履歴
    required List<AnswerRecord> answerRecords,
  }) = _QuizResult;

  factory QuizResult.fromJson(Map<String, dynamic> json) =>
      _$QuizResultFromJson(json);
}

/// カテゴリ別結果
@freezed
class CategoryResult with _$CategoryResult {
  const factory CategoryResult({
    required int total,
    required int correct,
    required double rate,
  }) = _CategoryResult;

  factory CategoryResult.fromJson(Map<String, dynamic> json) =>
      _$CategoryResultFromJson(json);
}

/// 回答記録
@freezed
class AnswerRecord with _$AnswerRecord {
  const factory AnswerRecord({
    required String questionId,
    required int selectedAnswer,
    required int correctAnswer,
    required bool isCorrect,
  }) = _AnswerRecord;

  factory AnswerRecord.fromJson(Map<String, dynamic> json) =>
      _$AnswerRecordFromJson(json);
}
