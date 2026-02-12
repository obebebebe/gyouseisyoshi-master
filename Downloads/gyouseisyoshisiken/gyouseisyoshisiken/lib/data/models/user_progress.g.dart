// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProgressImpl _$$UserProgressImplFromJson(Map<String, dynamic> json) =>
    _$UserProgressImpl(
      licenseType: json['licenseType'] as String,
      totalQuestions: (json['totalQuestions'] as num?)?.toInt() ?? 0,
      answeredQuestions: (json['answeredQuestions'] as num?)?.toInt() ?? 0,
      correctAnswers: (json['correctAnswers'] as num?)?.toInt() ?? 0,
      accuracyRate: (json['accuracyRate'] as num?)?.toDouble() ?? 0.0,
      totalStudyTimeMinutes:
          (json['totalStudyTimeMinutes'] as num?)?.toInt() ?? 0,
      lastStudiedAt: json['lastStudiedAt'] == null
          ? null
          : DateTime.parse(json['lastStudiedAt'] as String),
      consecutiveDays: (json['consecutiveDays'] as num?)?.toInt() ?? 0,
      weakCategories:
          (json['weakCategories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      categoryStats:
          (json['categoryStats'] as Map<String, dynamic>?)?.map(
            (k, e) =>
                MapEntry(k, CategoryStats.fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
    );

Map<String, dynamic> _$$UserProgressImplToJson(_$UserProgressImpl instance) =>
    <String, dynamic>{
      'licenseType': instance.licenseType,
      'totalQuestions': instance.totalQuestions,
      'answeredQuestions': instance.answeredQuestions,
      'correctAnswers': instance.correctAnswers,
      'accuracyRate': instance.accuracyRate,
      'totalStudyTimeMinutes': instance.totalStudyTimeMinutes,
      'lastStudiedAt': instance.lastStudiedAt?.toIso8601String(),
      'consecutiveDays': instance.consecutiveDays,
      'weakCategories': instance.weakCategories,
      'categoryStats': instance.categoryStats,
    };

_$CategoryStatsImpl _$$CategoryStatsImplFromJson(Map<String, dynamic> json) =>
    _$CategoryStatsImpl(
      totalQuestions: (json['totalQuestions'] as num?)?.toInt() ?? 0,
      correctAnswers: (json['correctAnswers'] as num?)?.toInt() ?? 0,
      accuracyRate: (json['accuracyRate'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$CategoryStatsImplToJson(_$CategoryStatsImpl instance) =>
    <String, dynamic>{
      'totalQuestions': instance.totalQuestions,
      'correctAnswers': instance.correctAnswers,
      'accuracyRate': instance.accuracyRate,
    };

_$OverallStatsImpl _$$OverallStatsImplFromJson(
  Map<String, dynamic> json,
) => _$OverallStatsImpl(
  totalAnswered: (json['totalAnswered'] as num?)?.toInt() ?? 0,
  totalCorrect: (json['totalCorrect'] as num?)?.toInt() ?? 0,
  overallAccuracyRate: (json['overallAccuracyRate'] as num?)?.toDouble() ?? 0.0,
  totalStudyTimeMinutes: (json['totalStudyTimeMinutes'] as num?)?.toInt() ?? 0,
  maxConsecutiveDays: (json['maxConsecutiveDays'] as num?)?.toInt() ?? 0,
  currentConsecutiveDays:
      (json['currentConsecutiveDays'] as num?)?.toInt() ?? 0,
  subjectProgress:
      (json['subjectProgress'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, UserProgress.fromJson(e as Map<String, dynamic>)),
      ) ??
      const {},
);

Map<String, dynamic> _$$OverallStatsImplToJson(_$OverallStatsImpl instance) =>
    <String, dynamic>{
      'totalAnswered': instance.totalAnswered,
      'totalCorrect': instance.totalCorrect,
      'overallAccuracyRate': instance.overallAccuracyRate,
      'totalStudyTimeMinutes': instance.totalStudyTimeMinutes,
      'maxConsecutiveDays': instance.maxConsecutiveDays,
      'currentConsecutiveDays': instance.currentConsecutiveDays,
      'subjectProgress': instance.subjectProgress,
    };
