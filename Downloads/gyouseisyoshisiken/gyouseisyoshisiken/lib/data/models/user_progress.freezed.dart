// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_progress.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserProgress _$UserProgressFromJson(Map<String, dynamic> json) {
  return _UserProgress.fromJson(json);
}

/// @nodoc
mixin _$UserProgress {
  /// 科目ID
  String get licenseType => throw _privateConstructorUsedError;

  /// 総問題数（その科目で解いた問題数）
  int get totalQuestions => throw _privateConstructorUsedError;

  /// 回答済み問題数
  int get answeredQuestions => throw _privateConstructorUsedError;

  /// 正解数
  int get correctAnswers => throw _privateConstructorUsedError;

  /// 正答率（0.0 - 1.0）
  double get accuracyRate => throw _privateConstructorUsedError;

  /// 総学習時間（分）
  int get totalStudyTimeMinutes => throw _privateConstructorUsedError;

  /// 最終学習日時
  DateTime? get lastStudiedAt => throw _privateConstructorUsedError;

  /// 連続学習日数
  int get consecutiveDays => throw _privateConstructorUsedError;

  /// 弱点カテゴリリスト
  List<String> get weakCategories => throw _privateConstructorUsedError;

  /// カテゴリ別統計
  Map<String, CategoryStats> get categoryStats =>
      throw _privateConstructorUsedError;

  /// Serializes this UserProgress to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserProgressCopyWith<UserProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProgressCopyWith<$Res> {
  factory $UserProgressCopyWith(
    UserProgress value,
    $Res Function(UserProgress) then,
  ) = _$UserProgressCopyWithImpl<$Res, UserProgress>;
  @useResult
  $Res call({
    String licenseType,
    int totalQuestions,
    int answeredQuestions,
    int correctAnswers,
    double accuracyRate,
    int totalStudyTimeMinutes,
    DateTime? lastStudiedAt,
    int consecutiveDays,
    List<String> weakCategories,
    Map<String, CategoryStats> categoryStats,
  });
}

/// @nodoc
class _$UserProgressCopyWithImpl<$Res, $Val extends UserProgress>
    implements $UserProgressCopyWith<$Res> {
  _$UserProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? licenseType = null,
    Object? totalQuestions = null,
    Object? answeredQuestions = null,
    Object? correctAnswers = null,
    Object? accuracyRate = null,
    Object? totalStudyTimeMinutes = null,
    Object? lastStudiedAt = freezed,
    Object? consecutiveDays = null,
    Object? weakCategories = null,
    Object? categoryStats = null,
  }) {
    return _then(
      _value.copyWith(
            licenseType: null == licenseType
                ? _value.licenseType
                : licenseType // ignore: cast_nullable_to_non_nullable
                      as String,
            totalQuestions: null == totalQuestions
                ? _value.totalQuestions
                : totalQuestions // ignore: cast_nullable_to_non_nullable
                      as int,
            answeredQuestions: null == answeredQuestions
                ? _value.answeredQuestions
                : answeredQuestions // ignore: cast_nullable_to_non_nullable
                      as int,
            correctAnswers: null == correctAnswers
                ? _value.correctAnswers
                : correctAnswers // ignore: cast_nullable_to_non_nullable
                      as int,
            accuracyRate: null == accuracyRate
                ? _value.accuracyRate
                : accuracyRate // ignore: cast_nullable_to_non_nullable
                      as double,
            totalStudyTimeMinutes: null == totalStudyTimeMinutes
                ? _value.totalStudyTimeMinutes
                : totalStudyTimeMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            lastStudiedAt: freezed == lastStudiedAt
                ? _value.lastStudiedAt
                : lastStudiedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            consecutiveDays: null == consecutiveDays
                ? _value.consecutiveDays
                : consecutiveDays // ignore: cast_nullable_to_non_nullable
                      as int,
            weakCategories: null == weakCategories
                ? _value.weakCategories
                : weakCategories // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            categoryStats: null == categoryStats
                ? _value.categoryStats
                : categoryStats // ignore: cast_nullable_to_non_nullable
                      as Map<String, CategoryStats>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserProgressImplCopyWith<$Res>
    implements $UserProgressCopyWith<$Res> {
  factory _$$UserProgressImplCopyWith(
    _$UserProgressImpl value,
    $Res Function(_$UserProgressImpl) then,
  ) = __$$UserProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String licenseType,
    int totalQuestions,
    int answeredQuestions,
    int correctAnswers,
    double accuracyRate,
    int totalStudyTimeMinutes,
    DateTime? lastStudiedAt,
    int consecutiveDays,
    List<String> weakCategories,
    Map<String, CategoryStats> categoryStats,
  });
}

/// @nodoc
class __$$UserProgressImplCopyWithImpl<$Res>
    extends _$UserProgressCopyWithImpl<$Res, _$UserProgressImpl>
    implements _$$UserProgressImplCopyWith<$Res> {
  __$$UserProgressImplCopyWithImpl(
    _$UserProgressImpl _value,
    $Res Function(_$UserProgressImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? licenseType = null,
    Object? totalQuestions = null,
    Object? answeredQuestions = null,
    Object? correctAnswers = null,
    Object? accuracyRate = null,
    Object? totalStudyTimeMinutes = null,
    Object? lastStudiedAt = freezed,
    Object? consecutiveDays = null,
    Object? weakCategories = null,
    Object? categoryStats = null,
  }) {
    return _then(
      _$UserProgressImpl(
        licenseType: null == licenseType
            ? _value.licenseType
            : licenseType // ignore: cast_nullable_to_non_nullable
                  as String,
        totalQuestions: null == totalQuestions
            ? _value.totalQuestions
            : totalQuestions // ignore: cast_nullable_to_non_nullable
                  as int,
        answeredQuestions: null == answeredQuestions
            ? _value.answeredQuestions
            : answeredQuestions // ignore: cast_nullable_to_non_nullable
                  as int,
        correctAnswers: null == correctAnswers
            ? _value.correctAnswers
            : correctAnswers // ignore: cast_nullable_to_non_nullable
                  as int,
        accuracyRate: null == accuracyRate
            ? _value.accuracyRate
            : accuracyRate // ignore: cast_nullable_to_non_nullable
                  as double,
        totalStudyTimeMinutes: null == totalStudyTimeMinutes
            ? _value.totalStudyTimeMinutes
            : totalStudyTimeMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        lastStudiedAt: freezed == lastStudiedAt
            ? _value.lastStudiedAt
            : lastStudiedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        consecutiveDays: null == consecutiveDays
            ? _value.consecutiveDays
            : consecutiveDays // ignore: cast_nullable_to_non_nullable
                  as int,
        weakCategories: null == weakCategories
            ? _value._weakCategories
            : weakCategories // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        categoryStats: null == categoryStats
            ? _value._categoryStats
            : categoryStats // ignore: cast_nullable_to_non_nullable
                  as Map<String, CategoryStats>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserProgressImpl implements _UserProgress {
  const _$UserProgressImpl({
    required this.licenseType,
    this.totalQuestions = 0,
    this.answeredQuestions = 0,
    this.correctAnswers = 0,
    this.accuracyRate = 0.0,
    this.totalStudyTimeMinutes = 0,
    this.lastStudiedAt,
    this.consecutiveDays = 0,
    final List<String> weakCategories = const [],
    final Map<String, CategoryStats> categoryStats = const {},
  }) : _weakCategories = weakCategories,
       _categoryStats = categoryStats;

  factory _$UserProgressImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProgressImplFromJson(json);

  /// 科目ID
  @override
  final String licenseType;

  /// 総問題数（その科目で解いた問題数）
  @override
  @JsonKey()
  final int totalQuestions;

  /// 回答済み問題数
  @override
  @JsonKey()
  final int answeredQuestions;

  /// 正解数
  @override
  @JsonKey()
  final int correctAnswers;

  /// 正答率（0.0 - 1.0）
  @override
  @JsonKey()
  final double accuracyRate;

  /// 総学習時間（分）
  @override
  @JsonKey()
  final int totalStudyTimeMinutes;

  /// 最終学習日時
  @override
  final DateTime? lastStudiedAt;

  /// 連続学習日数
  @override
  @JsonKey()
  final int consecutiveDays;

  /// 弱点カテゴリリスト
  final List<String> _weakCategories;

  /// 弱点カテゴリリスト
  @override
  @JsonKey()
  List<String> get weakCategories {
    if (_weakCategories is EqualUnmodifiableListView) return _weakCategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_weakCategories);
  }

  /// カテゴリ別統計
  final Map<String, CategoryStats> _categoryStats;

  /// カテゴリ別統計
  @override
  @JsonKey()
  Map<String, CategoryStats> get categoryStats {
    if (_categoryStats is EqualUnmodifiableMapView) return _categoryStats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_categoryStats);
  }

  @override
  String toString() {
    return 'UserProgress(licenseType: $licenseType, totalQuestions: $totalQuestions, answeredQuestions: $answeredQuestions, correctAnswers: $correctAnswers, accuracyRate: $accuracyRate, totalStudyTimeMinutes: $totalStudyTimeMinutes, lastStudiedAt: $lastStudiedAt, consecutiveDays: $consecutiveDays, weakCategories: $weakCategories, categoryStats: $categoryStats)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProgressImpl &&
            (identical(other.licenseType, licenseType) ||
                other.licenseType == licenseType) &&
            (identical(other.totalQuestions, totalQuestions) ||
                other.totalQuestions == totalQuestions) &&
            (identical(other.answeredQuestions, answeredQuestions) ||
                other.answeredQuestions == answeredQuestions) &&
            (identical(other.correctAnswers, correctAnswers) ||
                other.correctAnswers == correctAnswers) &&
            (identical(other.accuracyRate, accuracyRate) ||
                other.accuracyRate == accuracyRate) &&
            (identical(other.totalStudyTimeMinutes, totalStudyTimeMinutes) ||
                other.totalStudyTimeMinutes == totalStudyTimeMinutes) &&
            (identical(other.lastStudiedAt, lastStudiedAt) ||
                other.lastStudiedAt == lastStudiedAt) &&
            (identical(other.consecutiveDays, consecutiveDays) ||
                other.consecutiveDays == consecutiveDays) &&
            const DeepCollectionEquality().equals(
              other._weakCategories,
              _weakCategories,
            ) &&
            const DeepCollectionEquality().equals(
              other._categoryStats,
              _categoryStats,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    licenseType,
    totalQuestions,
    answeredQuestions,
    correctAnswers,
    accuracyRate,
    totalStudyTimeMinutes,
    lastStudiedAt,
    consecutiveDays,
    const DeepCollectionEquality().hash(_weakCategories),
    const DeepCollectionEquality().hash(_categoryStats),
  );

  /// Create a copy of UserProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProgressImplCopyWith<_$UserProgressImpl> get copyWith =>
      __$$UserProgressImplCopyWithImpl<_$UserProgressImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProgressImplToJson(this);
  }
}

abstract class _UserProgress implements UserProgress {
  const factory _UserProgress({
    required final String licenseType,
    final int totalQuestions,
    final int answeredQuestions,
    final int correctAnswers,
    final double accuracyRate,
    final int totalStudyTimeMinutes,
    final DateTime? lastStudiedAt,
    final int consecutiveDays,
    final List<String> weakCategories,
    final Map<String, CategoryStats> categoryStats,
  }) = _$UserProgressImpl;

  factory _UserProgress.fromJson(Map<String, dynamic> json) =
      _$UserProgressImpl.fromJson;

  /// 科目ID
  @override
  String get licenseType;

  /// 総問題数（その科目で解いた問題数）
  @override
  int get totalQuestions;

  /// 回答済み問題数
  @override
  int get answeredQuestions;

  /// 正解数
  @override
  int get correctAnswers;

  /// 正答率（0.0 - 1.0）
  @override
  double get accuracyRate;

  /// 総学習時間（分）
  @override
  int get totalStudyTimeMinutes;

  /// 最終学習日時
  @override
  DateTime? get lastStudiedAt;

  /// 連続学習日数
  @override
  int get consecutiveDays;

  /// 弱点カテゴリリスト
  @override
  List<String> get weakCategories;

  /// カテゴリ別統計
  @override
  Map<String, CategoryStats> get categoryStats;

  /// Create a copy of UserProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProgressImplCopyWith<_$UserProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CategoryStats _$CategoryStatsFromJson(Map<String, dynamic> json) {
  return _CategoryStats.fromJson(json);
}

/// @nodoc
mixin _$CategoryStats {
  /// 総問題数
  int get totalQuestions => throw _privateConstructorUsedError;

  /// 正解数
  int get correctAnswers => throw _privateConstructorUsedError;

  /// 正答率
  double get accuracyRate => throw _privateConstructorUsedError;

  /// Serializes this CategoryStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CategoryStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CategoryStatsCopyWith<CategoryStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryStatsCopyWith<$Res> {
  factory $CategoryStatsCopyWith(
    CategoryStats value,
    $Res Function(CategoryStats) then,
  ) = _$CategoryStatsCopyWithImpl<$Res, CategoryStats>;
  @useResult
  $Res call({int totalQuestions, int correctAnswers, double accuracyRate});
}

/// @nodoc
class _$CategoryStatsCopyWithImpl<$Res, $Val extends CategoryStats>
    implements $CategoryStatsCopyWith<$Res> {
  _$CategoryStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CategoryStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalQuestions = null,
    Object? correctAnswers = null,
    Object? accuracyRate = null,
  }) {
    return _then(
      _value.copyWith(
            totalQuestions: null == totalQuestions
                ? _value.totalQuestions
                : totalQuestions // ignore: cast_nullable_to_non_nullable
                      as int,
            correctAnswers: null == correctAnswers
                ? _value.correctAnswers
                : correctAnswers // ignore: cast_nullable_to_non_nullable
                      as int,
            accuracyRate: null == accuracyRate
                ? _value.accuracyRate
                : accuracyRate // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CategoryStatsImplCopyWith<$Res>
    implements $CategoryStatsCopyWith<$Res> {
  factory _$$CategoryStatsImplCopyWith(
    _$CategoryStatsImpl value,
    $Res Function(_$CategoryStatsImpl) then,
  ) = __$$CategoryStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int totalQuestions, int correctAnswers, double accuracyRate});
}

/// @nodoc
class __$$CategoryStatsImplCopyWithImpl<$Res>
    extends _$CategoryStatsCopyWithImpl<$Res, _$CategoryStatsImpl>
    implements _$$CategoryStatsImplCopyWith<$Res> {
  __$$CategoryStatsImplCopyWithImpl(
    _$CategoryStatsImpl _value,
    $Res Function(_$CategoryStatsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CategoryStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalQuestions = null,
    Object? correctAnswers = null,
    Object? accuracyRate = null,
  }) {
    return _then(
      _$CategoryStatsImpl(
        totalQuestions: null == totalQuestions
            ? _value.totalQuestions
            : totalQuestions // ignore: cast_nullable_to_non_nullable
                  as int,
        correctAnswers: null == correctAnswers
            ? _value.correctAnswers
            : correctAnswers // ignore: cast_nullable_to_non_nullable
                  as int,
        accuracyRate: null == accuracyRate
            ? _value.accuracyRate
            : accuracyRate // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CategoryStatsImpl implements _CategoryStats {
  const _$CategoryStatsImpl({
    this.totalQuestions = 0,
    this.correctAnswers = 0,
    this.accuracyRate = 0.0,
  });

  factory _$CategoryStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$CategoryStatsImplFromJson(json);

  /// 総問題数
  @override
  @JsonKey()
  final int totalQuestions;

  /// 正解数
  @override
  @JsonKey()
  final int correctAnswers;

  /// 正答率
  @override
  @JsonKey()
  final double accuracyRate;

  @override
  String toString() {
    return 'CategoryStats(totalQuestions: $totalQuestions, correctAnswers: $correctAnswers, accuracyRate: $accuracyRate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoryStatsImpl &&
            (identical(other.totalQuestions, totalQuestions) ||
                other.totalQuestions == totalQuestions) &&
            (identical(other.correctAnswers, correctAnswers) ||
                other.correctAnswers == correctAnswers) &&
            (identical(other.accuracyRate, accuracyRate) ||
                other.accuracyRate == accuracyRate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, totalQuestions, correctAnswers, accuracyRate);

  /// Create a copy of CategoryStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoryStatsImplCopyWith<_$CategoryStatsImpl> get copyWith =>
      __$$CategoryStatsImplCopyWithImpl<_$CategoryStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CategoryStatsImplToJson(this);
  }
}

abstract class _CategoryStats implements CategoryStats {
  const factory _CategoryStats({
    final int totalQuestions,
    final int correctAnswers,
    final double accuracyRate,
  }) = _$CategoryStatsImpl;

  factory _CategoryStats.fromJson(Map<String, dynamic> json) =
      _$CategoryStatsImpl.fromJson;

  /// 総問題数
  @override
  int get totalQuestions;

  /// 正解数
  @override
  int get correctAnswers;

  /// 正答率
  @override
  double get accuracyRate;

  /// Create a copy of CategoryStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CategoryStatsImplCopyWith<_$CategoryStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OverallStats _$OverallStatsFromJson(Map<String, dynamic> json) {
  return _OverallStats.fromJson(json);
}

/// @nodoc
mixin _$OverallStats {
  /// 総回答数
  int get totalAnswered => throw _privateConstructorUsedError;

  /// 総正解数
  int get totalCorrect => throw _privateConstructorUsedError;

  /// 全体正答率
  double get overallAccuracyRate => throw _privateConstructorUsedError;

  /// 総学習時間（分）
  int get totalStudyTimeMinutes => throw _privateConstructorUsedError;

  /// 最大連続日数
  int get maxConsecutiveDays => throw _privateConstructorUsedError;

  /// 現在の連続日数
  int get currentConsecutiveDays => throw _privateConstructorUsedError;

  /// 科目別進捗
  Map<String, UserProgress> get subjectProgress =>
      throw _privateConstructorUsedError;

  /// Serializes this OverallStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OverallStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OverallStatsCopyWith<OverallStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OverallStatsCopyWith<$Res> {
  factory $OverallStatsCopyWith(
    OverallStats value,
    $Res Function(OverallStats) then,
  ) = _$OverallStatsCopyWithImpl<$Res, OverallStats>;
  @useResult
  $Res call({
    int totalAnswered,
    int totalCorrect,
    double overallAccuracyRate,
    int totalStudyTimeMinutes,
    int maxConsecutiveDays,
    int currentConsecutiveDays,
    Map<String, UserProgress> subjectProgress,
  });
}

/// @nodoc
class _$OverallStatsCopyWithImpl<$Res, $Val extends OverallStats>
    implements $OverallStatsCopyWith<$Res> {
  _$OverallStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OverallStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalAnswered = null,
    Object? totalCorrect = null,
    Object? overallAccuracyRate = null,
    Object? totalStudyTimeMinutes = null,
    Object? maxConsecutiveDays = null,
    Object? currentConsecutiveDays = null,
    Object? subjectProgress = null,
  }) {
    return _then(
      _value.copyWith(
            totalAnswered: null == totalAnswered
                ? _value.totalAnswered
                : totalAnswered // ignore: cast_nullable_to_non_nullable
                      as int,
            totalCorrect: null == totalCorrect
                ? _value.totalCorrect
                : totalCorrect // ignore: cast_nullable_to_non_nullable
                      as int,
            overallAccuracyRate: null == overallAccuracyRate
                ? _value.overallAccuracyRate
                : overallAccuracyRate // ignore: cast_nullable_to_non_nullable
                      as double,
            totalStudyTimeMinutes: null == totalStudyTimeMinutes
                ? _value.totalStudyTimeMinutes
                : totalStudyTimeMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            maxConsecutiveDays: null == maxConsecutiveDays
                ? _value.maxConsecutiveDays
                : maxConsecutiveDays // ignore: cast_nullable_to_non_nullable
                      as int,
            currentConsecutiveDays: null == currentConsecutiveDays
                ? _value.currentConsecutiveDays
                : currentConsecutiveDays // ignore: cast_nullable_to_non_nullable
                      as int,
            subjectProgress: null == subjectProgress
                ? _value.subjectProgress
                : subjectProgress // ignore: cast_nullable_to_non_nullable
                      as Map<String, UserProgress>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OverallStatsImplCopyWith<$Res>
    implements $OverallStatsCopyWith<$Res> {
  factory _$$OverallStatsImplCopyWith(
    _$OverallStatsImpl value,
    $Res Function(_$OverallStatsImpl) then,
  ) = __$$OverallStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int totalAnswered,
    int totalCorrect,
    double overallAccuracyRate,
    int totalStudyTimeMinutes,
    int maxConsecutiveDays,
    int currentConsecutiveDays,
    Map<String, UserProgress> subjectProgress,
  });
}

/// @nodoc
class __$$OverallStatsImplCopyWithImpl<$Res>
    extends _$OverallStatsCopyWithImpl<$Res, _$OverallStatsImpl>
    implements _$$OverallStatsImplCopyWith<$Res> {
  __$$OverallStatsImplCopyWithImpl(
    _$OverallStatsImpl _value,
    $Res Function(_$OverallStatsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OverallStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalAnswered = null,
    Object? totalCorrect = null,
    Object? overallAccuracyRate = null,
    Object? totalStudyTimeMinutes = null,
    Object? maxConsecutiveDays = null,
    Object? currentConsecutiveDays = null,
    Object? subjectProgress = null,
  }) {
    return _then(
      _$OverallStatsImpl(
        totalAnswered: null == totalAnswered
            ? _value.totalAnswered
            : totalAnswered // ignore: cast_nullable_to_non_nullable
                  as int,
        totalCorrect: null == totalCorrect
            ? _value.totalCorrect
            : totalCorrect // ignore: cast_nullable_to_non_nullable
                  as int,
        overallAccuracyRate: null == overallAccuracyRate
            ? _value.overallAccuracyRate
            : overallAccuracyRate // ignore: cast_nullable_to_non_nullable
                  as double,
        totalStudyTimeMinutes: null == totalStudyTimeMinutes
            ? _value.totalStudyTimeMinutes
            : totalStudyTimeMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        maxConsecutiveDays: null == maxConsecutiveDays
            ? _value.maxConsecutiveDays
            : maxConsecutiveDays // ignore: cast_nullable_to_non_nullable
                  as int,
        currentConsecutiveDays: null == currentConsecutiveDays
            ? _value.currentConsecutiveDays
            : currentConsecutiveDays // ignore: cast_nullable_to_non_nullable
                  as int,
        subjectProgress: null == subjectProgress
            ? _value._subjectProgress
            : subjectProgress // ignore: cast_nullable_to_non_nullable
                  as Map<String, UserProgress>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OverallStatsImpl implements _OverallStats {
  const _$OverallStatsImpl({
    this.totalAnswered = 0,
    this.totalCorrect = 0,
    this.overallAccuracyRate = 0.0,
    this.totalStudyTimeMinutes = 0,
    this.maxConsecutiveDays = 0,
    this.currentConsecutiveDays = 0,
    final Map<String, UserProgress> subjectProgress = const {},
  }) : _subjectProgress = subjectProgress;

  factory _$OverallStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$OverallStatsImplFromJson(json);

  /// 総回答数
  @override
  @JsonKey()
  final int totalAnswered;

  /// 総正解数
  @override
  @JsonKey()
  final int totalCorrect;

  /// 全体正答率
  @override
  @JsonKey()
  final double overallAccuracyRate;

  /// 総学習時間（分）
  @override
  @JsonKey()
  final int totalStudyTimeMinutes;

  /// 最大連続日数
  @override
  @JsonKey()
  final int maxConsecutiveDays;

  /// 現在の連続日数
  @override
  @JsonKey()
  final int currentConsecutiveDays;

  /// 科目別進捗
  final Map<String, UserProgress> _subjectProgress;

  /// 科目別進捗
  @override
  @JsonKey()
  Map<String, UserProgress> get subjectProgress {
    if (_subjectProgress is EqualUnmodifiableMapView) return _subjectProgress;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_subjectProgress);
  }

  @override
  String toString() {
    return 'OverallStats(totalAnswered: $totalAnswered, totalCorrect: $totalCorrect, overallAccuracyRate: $overallAccuracyRate, totalStudyTimeMinutes: $totalStudyTimeMinutes, maxConsecutiveDays: $maxConsecutiveDays, currentConsecutiveDays: $currentConsecutiveDays, subjectProgress: $subjectProgress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OverallStatsImpl &&
            (identical(other.totalAnswered, totalAnswered) ||
                other.totalAnswered == totalAnswered) &&
            (identical(other.totalCorrect, totalCorrect) ||
                other.totalCorrect == totalCorrect) &&
            (identical(other.overallAccuracyRate, overallAccuracyRate) ||
                other.overallAccuracyRate == overallAccuracyRate) &&
            (identical(other.totalStudyTimeMinutes, totalStudyTimeMinutes) ||
                other.totalStudyTimeMinutes == totalStudyTimeMinutes) &&
            (identical(other.maxConsecutiveDays, maxConsecutiveDays) ||
                other.maxConsecutiveDays == maxConsecutiveDays) &&
            (identical(other.currentConsecutiveDays, currentConsecutiveDays) ||
                other.currentConsecutiveDays == currentConsecutiveDays) &&
            const DeepCollectionEquality().equals(
              other._subjectProgress,
              _subjectProgress,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    totalAnswered,
    totalCorrect,
    overallAccuracyRate,
    totalStudyTimeMinutes,
    maxConsecutiveDays,
    currentConsecutiveDays,
    const DeepCollectionEquality().hash(_subjectProgress),
  );

  /// Create a copy of OverallStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OverallStatsImplCopyWith<_$OverallStatsImpl> get copyWith =>
      __$$OverallStatsImplCopyWithImpl<_$OverallStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OverallStatsImplToJson(this);
  }
}

abstract class _OverallStats implements OverallStats {
  const factory _OverallStats({
    final int totalAnswered,
    final int totalCorrect,
    final double overallAccuracyRate,
    final int totalStudyTimeMinutes,
    final int maxConsecutiveDays,
    final int currentConsecutiveDays,
    final Map<String, UserProgress> subjectProgress,
  }) = _$OverallStatsImpl;

  factory _OverallStats.fromJson(Map<String, dynamic> json) =
      _$OverallStatsImpl.fromJson;

  /// 総回答数
  @override
  int get totalAnswered;

  /// 総正解数
  @override
  int get totalCorrect;

  /// 全体正答率
  @override
  double get overallAccuracyRate;

  /// 総学習時間（分）
  @override
  int get totalStudyTimeMinutes;

  /// 最大連続日数
  @override
  int get maxConsecutiveDays;

  /// 現在の連続日数
  @override
  int get currentConsecutiveDays;

  /// 科目別進捗
  @override
  Map<String, UserProgress> get subjectProgress;

  /// Create a copy of OverallStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OverallStatsImplCopyWith<_$OverallStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
