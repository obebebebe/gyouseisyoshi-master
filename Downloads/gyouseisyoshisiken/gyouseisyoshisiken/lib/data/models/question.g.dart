// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuestionImpl _$$QuestionImplFromJson(Map<String, dynamic> json) =>
    _$QuestionImpl(
      id: json['id'] as String,
      category: json['category'] as String,
      question: json['question'] as String,
      choices: (json['choices'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      correctAnswer: (json['correct_answer'] as num).toInt(),
      explanation: json['explanation'] as String,
      reference: json['reference'] as String?,
      difficulty: (json['difficulty'] as num?)?.toInt() ?? 1,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      year: (json['year'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$QuestionImplToJson(_$QuestionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'question': instance.question,
      'choices': instance.choices,
      'correct_answer': instance.correctAnswer,
      'explanation': instance.explanation,
      'reference': instance.reference,
      'difficulty': instance.difficulty,
      'tags': instance.tags,
      'year': instance.year,
    };

_$QuestionDataImpl _$$QuestionDataImplFromJson(Map<String, dynamic> json) =>
    _$QuestionDataImpl(
      licenseType: json['license_type'] as String,
      version: json['version'] as String,
      lastUpdated: json['last_updated'] as String,
      questions: (json['questions'] as List<dynamic>)
          .map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$QuestionDataImplToJson(_$QuestionDataImpl instance) =>
    <String, dynamic>{
      'license_type': instance.licenseType,
      'version': instance.version,
      'last_updated': instance.lastUpdated,
      'questions': instance.questions,
    };

_$QuizResultImpl _$$QuizResultImplFromJson(Map<String, dynamic> json) =>
    _$QuizResultImpl(
      totalQuestions: (json['totalQuestions'] as num).toInt(),
      correctAnswers: (json['correctAnswers'] as num).toInt(),
      accuracyRate: (json['accuracyRate'] as num).toDouble(),
      isPassed: json['isPassed'] as bool,
      elapsedSeconds: (json['elapsedSeconds'] as num).toInt(),
      categoryResults: (json['categoryResults'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, CategoryResult.fromJson(e as Map<String, dynamic>)),
      ),
      answerRecords: (json['answerRecords'] as List<dynamic>)
          .map((e) => AnswerRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$QuizResultImplToJson(_$QuizResultImpl instance) =>
    <String, dynamic>{
      'totalQuestions': instance.totalQuestions,
      'correctAnswers': instance.correctAnswers,
      'accuracyRate': instance.accuracyRate,
      'isPassed': instance.isPassed,
      'elapsedSeconds': instance.elapsedSeconds,
      'categoryResults': instance.categoryResults,
      'answerRecords': instance.answerRecords,
    };

_$CategoryResultImpl _$$CategoryResultImplFromJson(Map<String, dynamic> json) =>
    _$CategoryResultImpl(
      total: (json['total'] as num).toInt(),
      correct: (json['correct'] as num).toInt(),
      rate: (json['rate'] as num).toDouble(),
    );

Map<String, dynamic> _$$CategoryResultImplToJson(
  _$CategoryResultImpl instance,
) => <String, dynamic>{
  'total': instance.total,
  'correct': instance.correct,
  'rate': instance.rate,
};

_$AnswerRecordImpl _$$AnswerRecordImplFromJson(Map<String, dynamic> json) =>
    _$AnswerRecordImpl(
      questionId: json['questionId'] as String,
      selectedAnswer: (json['selectedAnswer'] as num).toInt(),
      correctAnswer: (json['correctAnswer'] as num).toInt(),
      isCorrect: json['isCorrect'] as bool,
    );

Map<String, dynamic> _$$AnswerRecordImplToJson(_$AnswerRecordImpl instance) =>
    <String, dynamic>{
      'questionId': instance.questionId,
      'selectedAnswer': instance.selectedAnswer,
      'correctAnswer': instance.correctAnswer,
      'isCorrect': instance.isCorrect,
    };
