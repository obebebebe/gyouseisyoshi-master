// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'question.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Question _$QuestionFromJson(Map<String, dynamic> json) {
  return _Question.fromJson(json);
}

/// @nodoc
mixin _$Question {
  /// 問題ID（例: "constitution_001"）
  String get id => throw _privateConstructorUsedError;

  /// 科目カテゴリ（例: "憲法"）
  String get category => throw _privateConstructorUsedError;

  /// 問題文
  String get question => throw _privateConstructorUsedError;

  /// 選択肢リスト（5択）
  List<String> get choices => throw _privateConstructorUsedError;

  /// 正解のインデックス（0始まり）
  @JsonKey(name: 'correct_answer')
  int get correctAnswer => throw _privateConstructorUsedError;

  /// 解説文
  String get explanation => throw _privateConstructorUsedError;

  /// 法令参照（任意）
  String? get reference => throw _privateConstructorUsedError;

  /// 難易度（1: 易, 2: 普通, 3: 難）
  int get difficulty => throw _privateConstructorUsedError;

  /// タグ（検索用）
  List<String> get tags => throw _privateConstructorUsedError;

  /// 年度（過去問の場合）
  int? get year => throw _privateConstructorUsedError;

  /// Serializes this Question to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Question
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuestionCopyWith<Question> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestionCopyWith<$Res> {
  factory $QuestionCopyWith(Question value, $Res Function(Question) then) =
      _$QuestionCopyWithImpl<$Res, Question>;
  @useResult
  $Res call({
    String id,
    String category,
    String question,
    List<String> choices,
    @JsonKey(name: 'correct_answer') int correctAnswer,
    String explanation,
    String? reference,
    int difficulty,
    List<String> tags,
    int? year,
  });
}

/// @nodoc
class _$QuestionCopyWithImpl<$Res, $Val extends Question>
    implements $QuestionCopyWith<$Res> {
  _$QuestionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Question
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? category = null,
    Object? question = null,
    Object? choices = null,
    Object? correctAnswer = null,
    Object? explanation = null,
    Object? reference = freezed,
    Object? difficulty = null,
    Object? tags = null,
    Object? year = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            question: null == question
                ? _value.question
                : question // ignore: cast_nullable_to_non_nullable
                      as String,
            choices: null == choices
                ? _value.choices
                : choices // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            correctAnswer: null == correctAnswer
                ? _value.correctAnswer
                : correctAnswer // ignore: cast_nullable_to_non_nullable
                      as int,
            explanation: null == explanation
                ? _value.explanation
                : explanation // ignore: cast_nullable_to_non_nullable
                      as String,
            reference: freezed == reference
                ? _value.reference
                : reference // ignore: cast_nullable_to_non_nullable
                      as String?,
            difficulty: null == difficulty
                ? _value.difficulty
                : difficulty // ignore: cast_nullable_to_non_nullable
                      as int,
            tags: null == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            year: freezed == year
                ? _value.year
                : year // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QuestionImplCopyWith<$Res>
    implements $QuestionCopyWith<$Res> {
  factory _$$QuestionImplCopyWith(
    _$QuestionImpl value,
    $Res Function(_$QuestionImpl) then,
  ) = __$$QuestionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String category,
    String question,
    List<String> choices,
    @JsonKey(name: 'correct_answer') int correctAnswer,
    String explanation,
    String? reference,
    int difficulty,
    List<String> tags,
    int? year,
  });
}

/// @nodoc
class __$$QuestionImplCopyWithImpl<$Res>
    extends _$QuestionCopyWithImpl<$Res, _$QuestionImpl>
    implements _$$QuestionImplCopyWith<$Res> {
  __$$QuestionImplCopyWithImpl(
    _$QuestionImpl _value,
    $Res Function(_$QuestionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Question
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? category = null,
    Object? question = null,
    Object? choices = null,
    Object? correctAnswer = null,
    Object? explanation = null,
    Object? reference = freezed,
    Object? difficulty = null,
    Object? tags = null,
    Object? year = freezed,
  }) {
    return _then(
      _$QuestionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        question: null == question
            ? _value.question
            : question // ignore: cast_nullable_to_non_nullable
                  as String,
        choices: null == choices
            ? _value._choices
            : choices // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        correctAnswer: null == correctAnswer
            ? _value.correctAnswer
            : correctAnswer // ignore: cast_nullable_to_non_nullable
                  as int,
        explanation: null == explanation
            ? _value.explanation
            : explanation // ignore: cast_nullable_to_non_nullable
                  as String,
        reference: freezed == reference
            ? _value.reference
            : reference // ignore: cast_nullable_to_non_nullable
                  as String?,
        difficulty: null == difficulty
            ? _value.difficulty
            : difficulty // ignore: cast_nullable_to_non_nullable
                  as int,
        tags: null == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        year: freezed == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QuestionImpl implements _Question {
  const _$QuestionImpl({
    required this.id,
    required this.category,
    required this.question,
    required final List<String> choices,
    @JsonKey(name: 'correct_answer') required this.correctAnswer,
    required this.explanation,
    this.reference,
    this.difficulty = 1,
    final List<String> tags = const [],
    this.year,
  }) : _choices = choices,
       _tags = tags;

  factory _$QuestionImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuestionImplFromJson(json);

  /// 問題ID（例: "constitution_001"）
  @override
  final String id;

  /// 科目カテゴリ（例: "憲法"）
  @override
  final String category;

  /// 問題文
  @override
  final String question;

  /// 選択肢リスト（5択）
  final List<String> _choices;

  /// 選択肢リスト（5択）
  @override
  List<String> get choices {
    if (_choices is EqualUnmodifiableListView) return _choices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_choices);
  }

  /// 正解のインデックス（0始まり）
  @override
  @JsonKey(name: 'correct_answer')
  final int correctAnswer;

  /// 解説文
  @override
  final String explanation;

  /// 法令参照（任意）
  @override
  final String? reference;

  /// 難易度（1: 易, 2: 普通, 3: 難）
  @override
  @JsonKey()
  final int difficulty;

  /// タグ（検索用）
  final List<String> _tags;

  /// タグ（検索用）
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  /// 年度（過去問の場合）
  @override
  final int? year;

  @override
  String toString() {
    return 'Question(id: $id, category: $category, question: $question, choices: $choices, correctAnswer: $correctAnswer, explanation: $explanation, reference: $reference, difficulty: $difficulty, tags: $tags, year: $year)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuestionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.question, question) ||
                other.question == question) &&
            const DeepCollectionEquality().equals(other._choices, _choices) &&
            (identical(other.correctAnswer, correctAnswer) ||
                other.correctAnswer == correctAnswer) &&
            (identical(other.explanation, explanation) ||
                other.explanation == explanation) &&
            (identical(other.reference, reference) ||
                other.reference == reference) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.year, year) || other.year == year));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    category,
    question,
    const DeepCollectionEquality().hash(_choices),
    correctAnswer,
    explanation,
    reference,
    difficulty,
    const DeepCollectionEquality().hash(_tags),
    year,
  );

  /// Create a copy of Question
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuestionImplCopyWith<_$QuestionImpl> get copyWith =>
      __$$QuestionImplCopyWithImpl<_$QuestionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuestionImplToJson(this);
  }
}

abstract class _Question implements Question {
  const factory _Question({
    required final String id,
    required final String category,
    required final String question,
    required final List<String> choices,
    @JsonKey(name: 'correct_answer') required final int correctAnswer,
    required final String explanation,
    final String? reference,
    final int difficulty,
    final List<String> tags,
    final int? year,
  }) = _$QuestionImpl;

  factory _Question.fromJson(Map<String, dynamic> json) =
      _$QuestionImpl.fromJson;

  /// 問題ID（例: "constitution_001"）
  @override
  String get id;

  /// 科目カテゴリ（例: "憲法"）
  @override
  String get category;

  /// 問題文
  @override
  String get question;

  /// 選択肢リスト（5択）
  @override
  List<String> get choices;

  /// 正解のインデックス（0始まり）
  @override
  @JsonKey(name: 'correct_answer')
  int get correctAnswer;

  /// 解説文
  @override
  String get explanation;

  /// 法令参照（任意）
  @override
  String? get reference;

  /// 難易度（1: 易, 2: 普通, 3: 難）
  @override
  int get difficulty;

  /// タグ（検索用）
  @override
  List<String> get tags;

  /// 年度（過去問の場合）
  @override
  int? get year;

  /// Create a copy of Question
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuestionImplCopyWith<_$QuestionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QuestionData _$QuestionDataFromJson(Map<String, dynamic> json) {
  return _QuestionData.fromJson(json);
}

/// @nodoc
mixin _$QuestionData {
  /// 科目ID
  @JsonKey(name: 'license_type')
  String get licenseType => throw _privateConstructorUsedError;

  /// データバージョン
  String get version => throw _privateConstructorUsedError;

  /// 最終更新日
  @JsonKey(name: 'last_updated')
  String get lastUpdated => throw _privateConstructorUsedError;

  /// 問題リスト
  List<Question> get questions => throw _privateConstructorUsedError;

  /// Serializes this QuestionData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuestionData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuestionDataCopyWith<QuestionData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestionDataCopyWith<$Res> {
  factory $QuestionDataCopyWith(
    QuestionData value,
    $Res Function(QuestionData) then,
  ) = _$QuestionDataCopyWithImpl<$Res, QuestionData>;
  @useResult
  $Res call({
    @JsonKey(name: 'license_type') String licenseType,
    String version,
    @JsonKey(name: 'last_updated') String lastUpdated,
    List<Question> questions,
  });
}

/// @nodoc
class _$QuestionDataCopyWithImpl<$Res, $Val extends QuestionData>
    implements $QuestionDataCopyWith<$Res> {
  _$QuestionDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuestionData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? licenseType = null,
    Object? version = null,
    Object? lastUpdated = null,
    Object? questions = null,
  }) {
    return _then(
      _value.copyWith(
            licenseType: null == licenseType
                ? _value.licenseType
                : licenseType // ignore: cast_nullable_to_non_nullable
                      as String,
            version: null == version
                ? _value.version
                : version // ignore: cast_nullable_to_non_nullable
                      as String,
            lastUpdated: null == lastUpdated
                ? _value.lastUpdated
                : lastUpdated // ignore: cast_nullable_to_non_nullable
                      as String,
            questions: null == questions
                ? _value.questions
                : questions // ignore: cast_nullable_to_non_nullable
                      as List<Question>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QuestionDataImplCopyWith<$Res>
    implements $QuestionDataCopyWith<$Res> {
  factory _$$QuestionDataImplCopyWith(
    _$QuestionDataImpl value,
    $Res Function(_$QuestionDataImpl) then,
  ) = __$$QuestionDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'license_type') String licenseType,
    String version,
    @JsonKey(name: 'last_updated') String lastUpdated,
    List<Question> questions,
  });
}

/// @nodoc
class __$$QuestionDataImplCopyWithImpl<$Res>
    extends _$QuestionDataCopyWithImpl<$Res, _$QuestionDataImpl>
    implements _$$QuestionDataImplCopyWith<$Res> {
  __$$QuestionDataImplCopyWithImpl(
    _$QuestionDataImpl _value,
    $Res Function(_$QuestionDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QuestionData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? licenseType = null,
    Object? version = null,
    Object? lastUpdated = null,
    Object? questions = null,
  }) {
    return _then(
      _$QuestionDataImpl(
        licenseType: null == licenseType
            ? _value.licenseType
            : licenseType // ignore: cast_nullable_to_non_nullable
                  as String,
        version: null == version
            ? _value.version
            : version // ignore: cast_nullable_to_non_nullable
                  as String,
        lastUpdated: null == lastUpdated
            ? _value.lastUpdated
            : lastUpdated // ignore: cast_nullable_to_non_nullable
                  as String,
        questions: null == questions
            ? _value._questions
            : questions // ignore: cast_nullable_to_non_nullable
                  as List<Question>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QuestionDataImpl implements _QuestionData {
  const _$QuestionDataImpl({
    @JsonKey(name: 'license_type') required this.licenseType,
    required this.version,
    @JsonKey(name: 'last_updated') required this.lastUpdated,
    required final List<Question> questions,
  }) : _questions = questions;

  factory _$QuestionDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuestionDataImplFromJson(json);

  /// 科目ID
  @override
  @JsonKey(name: 'license_type')
  final String licenseType;

  /// データバージョン
  @override
  final String version;

  /// 最終更新日
  @override
  @JsonKey(name: 'last_updated')
  final String lastUpdated;

  /// 問題リスト
  final List<Question> _questions;

  /// 問題リスト
  @override
  List<Question> get questions {
    if (_questions is EqualUnmodifiableListView) return _questions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questions);
  }

  @override
  String toString() {
    return 'QuestionData(licenseType: $licenseType, version: $version, lastUpdated: $lastUpdated, questions: $questions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuestionDataImpl &&
            (identical(other.licenseType, licenseType) ||
                other.licenseType == licenseType) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            const DeepCollectionEquality().equals(
              other._questions,
              _questions,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    licenseType,
    version,
    lastUpdated,
    const DeepCollectionEquality().hash(_questions),
  );

  /// Create a copy of QuestionData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuestionDataImplCopyWith<_$QuestionDataImpl> get copyWith =>
      __$$QuestionDataImplCopyWithImpl<_$QuestionDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuestionDataImplToJson(this);
  }
}

abstract class _QuestionData implements QuestionData {
  const factory _QuestionData({
    @JsonKey(name: 'license_type') required final String licenseType,
    required final String version,
    @JsonKey(name: 'last_updated') required final String lastUpdated,
    required final List<Question> questions,
  }) = _$QuestionDataImpl;

  factory _QuestionData.fromJson(Map<String, dynamic> json) =
      _$QuestionDataImpl.fromJson;

  /// 科目ID
  @override
  @JsonKey(name: 'license_type')
  String get licenseType;

  /// データバージョン
  @override
  String get version;

  /// 最終更新日
  @override
  @JsonKey(name: 'last_updated')
  String get lastUpdated;

  /// 問題リスト
  @override
  List<Question> get questions;

  /// Create a copy of QuestionData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuestionDataImplCopyWith<_$QuestionDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QuizResult _$QuizResultFromJson(Map<String, dynamic> json) {
  return _QuizResult.fromJson(json);
}

/// @nodoc
mixin _$QuizResult {
  /// 総問題数
  int get totalQuestions => throw _privateConstructorUsedError;

  /// 正解数
  int get correctAnswers => throw _privateConstructorUsedError;

  /// 正答率
  double get accuracyRate => throw _privateConstructorUsedError;

  /// 合格判定
  bool get isPassed => throw _privateConstructorUsedError;

  /// 所要時間（秒）
  int get elapsedSeconds => throw _privateConstructorUsedError;

  /// カテゴリ別成績
  Map<String, CategoryResult> get categoryResults =>
      throw _privateConstructorUsedError;

  /// 回答履歴
  List<AnswerRecord> get answerRecords => throw _privateConstructorUsedError;

  /// Serializes this QuizResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuizResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuizResultCopyWith<QuizResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuizResultCopyWith<$Res> {
  factory $QuizResultCopyWith(
    QuizResult value,
    $Res Function(QuizResult) then,
  ) = _$QuizResultCopyWithImpl<$Res, QuizResult>;
  @useResult
  $Res call({
    int totalQuestions,
    int correctAnswers,
    double accuracyRate,
    bool isPassed,
    int elapsedSeconds,
    Map<String, CategoryResult> categoryResults,
    List<AnswerRecord> answerRecords,
  });
}

/// @nodoc
class _$QuizResultCopyWithImpl<$Res, $Val extends QuizResult>
    implements $QuizResultCopyWith<$Res> {
  _$QuizResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuizResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalQuestions = null,
    Object? correctAnswers = null,
    Object? accuracyRate = null,
    Object? isPassed = null,
    Object? elapsedSeconds = null,
    Object? categoryResults = null,
    Object? answerRecords = null,
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
            isPassed: null == isPassed
                ? _value.isPassed
                : isPassed // ignore: cast_nullable_to_non_nullable
                      as bool,
            elapsedSeconds: null == elapsedSeconds
                ? _value.elapsedSeconds
                : elapsedSeconds // ignore: cast_nullable_to_non_nullable
                      as int,
            categoryResults: null == categoryResults
                ? _value.categoryResults
                : categoryResults // ignore: cast_nullable_to_non_nullable
                      as Map<String, CategoryResult>,
            answerRecords: null == answerRecords
                ? _value.answerRecords
                : answerRecords // ignore: cast_nullable_to_non_nullable
                      as List<AnswerRecord>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QuizResultImplCopyWith<$Res>
    implements $QuizResultCopyWith<$Res> {
  factory _$$QuizResultImplCopyWith(
    _$QuizResultImpl value,
    $Res Function(_$QuizResultImpl) then,
  ) = __$$QuizResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int totalQuestions,
    int correctAnswers,
    double accuracyRate,
    bool isPassed,
    int elapsedSeconds,
    Map<String, CategoryResult> categoryResults,
    List<AnswerRecord> answerRecords,
  });
}

/// @nodoc
class __$$QuizResultImplCopyWithImpl<$Res>
    extends _$QuizResultCopyWithImpl<$Res, _$QuizResultImpl>
    implements _$$QuizResultImplCopyWith<$Res> {
  __$$QuizResultImplCopyWithImpl(
    _$QuizResultImpl _value,
    $Res Function(_$QuizResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QuizResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalQuestions = null,
    Object? correctAnswers = null,
    Object? accuracyRate = null,
    Object? isPassed = null,
    Object? elapsedSeconds = null,
    Object? categoryResults = null,
    Object? answerRecords = null,
  }) {
    return _then(
      _$QuizResultImpl(
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
        isPassed: null == isPassed
            ? _value.isPassed
            : isPassed // ignore: cast_nullable_to_non_nullable
                  as bool,
        elapsedSeconds: null == elapsedSeconds
            ? _value.elapsedSeconds
            : elapsedSeconds // ignore: cast_nullable_to_non_nullable
                  as int,
        categoryResults: null == categoryResults
            ? _value._categoryResults
            : categoryResults // ignore: cast_nullable_to_non_nullable
                  as Map<String, CategoryResult>,
        answerRecords: null == answerRecords
            ? _value._answerRecords
            : answerRecords // ignore: cast_nullable_to_non_nullable
                  as List<AnswerRecord>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QuizResultImpl implements _QuizResult {
  const _$QuizResultImpl({
    required this.totalQuestions,
    required this.correctAnswers,
    required this.accuracyRate,
    required this.isPassed,
    required this.elapsedSeconds,
    required final Map<String, CategoryResult> categoryResults,
    required final List<AnswerRecord> answerRecords,
  }) : _categoryResults = categoryResults,
       _answerRecords = answerRecords;

  factory _$QuizResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuizResultImplFromJson(json);

  /// 総問題数
  @override
  final int totalQuestions;

  /// 正解数
  @override
  final int correctAnswers;

  /// 正答率
  @override
  final double accuracyRate;

  /// 合格判定
  @override
  final bool isPassed;

  /// 所要時間（秒）
  @override
  final int elapsedSeconds;

  /// カテゴリ別成績
  final Map<String, CategoryResult> _categoryResults;

  /// カテゴリ別成績
  @override
  Map<String, CategoryResult> get categoryResults {
    if (_categoryResults is EqualUnmodifiableMapView) return _categoryResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_categoryResults);
  }

  /// 回答履歴
  final List<AnswerRecord> _answerRecords;

  /// 回答履歴
  @override
  List<AnswerRecord> get answerRecords {
    if (_answerRecords is EqualUnmodifiableListView) return _answerRecords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_answerRecords);
  }

  @override
  String toString() {
    return 'QuizResult(totalQuestions: $totalQuestions, correctAnswers: $correctAnswers, accuracyRate: $accuracyRate, isPassed: $isPassed, elapsedSeconds: $elapsedSeconds, categoryResults: $categoryResults, answerRecords: $answerRecords)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuizResultImpl &&
            (identical(other.totalQuestions, totalQuestions) ||
                other.totalQuestions == totalQuestions) &&
            (identical(other.correctAnswers, correctAnswers) ||
                other.correctAnswers == correctAnswers) &&
            (identical(other.accuracyRate, accuracyRate) ||
                other.accuracyRate == accuracyRate) &&
            (identical(other.isPassed, isPassed) ||
                other.isPassed == isPassed) &&
            (identical(other.elapsedSeconds, elapsedSeconds) ||
                other.elapsedSeconds == elapsedSeconds) &&
            const DeepCollectionEquality().equals(
              other._categoryResults,
              _categoryResults,
            ) &&
            const DeepCollectionEquality().equals(
              other._answerRecords,
              _answerRecords,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    totalQuestions,
    correctAnswers,
    accuracyRate,
    isPassed,
    elapsedSeconds,
    const DeepCollectionEquality().hash(_categoryResults),
    const DeepCollectionEquality().hash(_answerRecords),
  );

  /// Create a copy of QuizResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuizResultImplCopyWith<_$QuizResultImpl> get copyWith =>
      __$$QuizResultImplCopyWithImpl<_$QuizResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuizResultImplToJson(this);
  }
}

abstract class _QuizResult implements QuizResult {
  const factory _QuizResult({
    required final int totalQuestions,
    required final int correctAnswers,
    required final double accuracyRate,
    required final bool isPassed,
    required final int elapsedSeconds,
    required final Map<String, CategoryResult> categoryResults,
    required final List<AnswerRecord> answerRecords,
  }) = _$QuizResultImpl;

  factory _QuizResult.fromJson(Map<String, dynamic> json) =
      _$QuizResultImpl.fromJson;

  /// 総問題数
  @override
  int get totalQuestions;

  /// 正解数
  @override
  int get correctAnswers;

  /// 正答率
  @override
  double get accuracyRate;

  /// 合格判定
  @override
  bool get isPassed;

  /// 所要時間（秒）
  @override
  int get elapsedSeconds;

  /// カテゴリ別成績
  @override
  Map<String, CategoryResult> get categoryResults;

  /// 回答履歴
  @override
  List<AnswerRecord> get answerRecords;

  /// Create a copy of QuizResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuizResultImplCopyWith<_$QuizResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CategoryResult _$CategoryResultFromJson(Map<String, dynamic> json) {
  return _CategoryResult.fromJson(json);
}

/// @nodoc
mixin _$CategoryResult {
  int get total => throw _privateConstructorUsedError;
  int get correct => throw _privateConstructorUsedError;
  double get rate => throw _privateConstructorUsedError;

  /// Serializes this CategoryResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CategoryResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CategoryResultCopyWith<CategoryResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryResultCopyWith<$Res> {
  factory $CategoryResultCopyWith(
    CategoryResult value,
    $Res Function(CategoryResult) then,
  ) = _$CategoryResultCopyWithImpl<$Res, CategoryResult>;
  @useResult
  $Res call({int total, int correct, double rate});
}

/// @nodoc
class _$CategoryResultCopyWithImpl<$Res, $Val extends CategoryResult>
    implements $CategoryResultCopyWith<$Res> {
  _$CategoryResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CategoryResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? correct = null,
    Object? rate = null,
  }) {
    return _then(
      _value.copyWith(
            total: null == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                      as int,
            correct: null == correct
                ? _value.correct
                : correct // ignore: cast_nullable_to_non_nullable
                      as int,
            rate: null == rate
                ? _value.rate
                : rate // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CategoryResultImplCopyWith<$Res>
    implements $CategoryResultCopyWith<$Res> {
  factory _$$CategoryResultImplCopyWith(
    _$CategoryResultImpl value,
    $Res Function(_$CategoryResultImpl) then,
  ) = __$$CategoryResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int total, int correct, double rate});
}

/// @nodoc
class __$$CategoryResultImplCopyWithImpl<$Res>
    extends _$CategoryResultCopyWithImpl<$Res, _$CategoryResultImpl>
    implements _$$CategoryResultImplCopyWith<$Res> {
  __$$CategoryResultImplCopyWithImpl(
    _$CategoryResultImpl _value,
    $Res Function(_$CategoryResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CategoryResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? correct = null,
    Object? rate = null,
  }) {
    return _then(
      _$CategoryResultImpl(
        total: null == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as int,
        correct: null == correct
            ? _value.correct
            : correct // ignore: cast_nullable_to_non_nullable
                  as int,
        rate: null == rate
            ? _value.rate
            : rate // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CategoryResultImpl implements _CategoryResult {
  const _$CategoryResultImpl({
    required this.total,
    required this.correct,
    required this.rate,
  });

  factory _$CategoryResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$CategoryResultImplFromJson(json);

  @override
  final int total;
  @override
  final int correct;
  @override
  final double rate;

  @override
  String toString() {
    return 'CategoryResult(total: $total, correct: $correct, rate: $rate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoryResultImpl &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.correct, correct) || other.correct == correct) &&
            (identical(other.rate, rate) || other.rate == rate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, total, correct, rate);

  /// Create a copy of CategoryResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoryResultImplCopyWith<_$CategoryResultImpl> get copyWith =>
      __$$CategoryResultImplCopyWithImpl<_$CategoryResultImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CategoryResultImplToJson(this);
  }
}

abstract class _CategoryResult implements CategoryResult {
  const factory _CategoryResult({
    required final int total,
    required final int correct,
    required final double rate,
  }) = _$CategoryResultImpl;

  factory _CategoryResult.fromJson(Map<String, dynamic> json) =
      _$CategoryResultImpl.fromJson;

  @override
  int get total;
  @override
  int get correct;
  @override
  double get rate;

  /// Create a copy of CategoryResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CategoryResultImplCopyWith<_$CategoryResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AnswerRecord _$AnswerRecordFromJson(Map<String, dynamic> json) {
  return _AnswerRecord.fromJson(json);
}

/// @nodoc
mixin _$AnswerRecord {
  String get questionId => throw _privateConstructorUsedError;
  int get selectedAnswer => throw _privateConstructorUsedError;
  int get correctAnswer => throw _privateConstructorUsedError;
  bool get isCorrect => throw _privateConstructorUsedError;

  /// Serializes this AnswerRecord to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AnswerRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnswerRecordCopyWith<AnswerRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnswerRecordCopyWith<$Res> {
  factory $AnswerRecordCopyWith(
    AnswerRecord value,
    $Res Function(AnswerRecord) then,
  ) = _$AnswerRecordCopyWithImpl<$Res, AnswerRecord>;
  @useResult
  $Res call({
    String questionId,
    int selectedAnswer,
    int correctAnswer,
    bool isCorrect,
  });
}

/// @nodoc
class _$AnswerRecordCopyWithImpl<$Res, $Val extends AnswerRecord>
    implements $AnswerRecordCopyWith<$Res> {
  _$AnswerRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnswerRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionId = null,
    Object? selectedAnswer = null,
    Object? correctAnswer = null,
    Object? isCorrect = null,
  }) {
    return _then(
      _value.copyWith(
            questionId: null == questionId
                ? _value.questionId
                : questionId // ignore: cast_nullable_to_non_nullable
                      as String,
            selectedAnswer: null == selectedAnswer
                ? _value.selectedAnswer
                : selectedAnswer // ignore: cast_nullable_to_non_nullable
                      as int,
            correctAnswer: null == correctAnswer
                ? _value.correctAnswer
                : correctAnswer // ignore: cast_nullable_to_non_nullable
                      as int,
            isCorrect: null == isCorrect
                ? _value.isCorrect
                : isCorrect // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AnswerRecordImplCopyWith<$Res>
    implements $AnswerRecordCopyWith<$Res> {
  factory _$$AnswerRecordImplCopyWith(
    _$AnswerRecordImpl value,
    $Res Function(_$AnswerRecordImpl) then,
  ) = __$$AnswerRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String questionId,
    int selectedAnswer,
    int correctAnswer,
    bool isCorrect,
  });
}

/// @nodoc
class __$$AnswerRecordImplCopyWithImpl<$Res>
    extends _$AnswerRecordCopyWithImpl<$Res, _$AnswerRecordImpl>
    implements _$$AnswerRecordImplCopyWith<$Res> {
  __$$AnswerRecordImplCopyWithImpl(
    _$AnswerRecordImpl _value,
    $Res Function(_$AnswerRecordImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AnswerRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionId = null,
    Object? selectedAnswer = null,
    Object? correctAnswer = null,
    Object? isCorrect = null,
  }) {
    return _then(
      _$AnswerRecordImpl(
        questionId: null == questionId
            ? _value.questionId
            : questionId // ignore: cast_nullable_to_non_nullable
                  as String,
        selectedAnswer: null == selectedAnswer
            ? _value.selectedAnswer
            : selectedAnswer // ignore: cast_nullable_to_non_nullable
                  as int,
        correctAnswer: null == correctAnswer
            ? _value.correctAnswer
            : correctAnswer // ignore: cast_nullable_to_non_nullable
                  as int,
        isCorrect: null == isCorrect
            ? _value.isCorrect
            : isCorrect // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AnswerRecordImpl implements _AnswerRecord {
  const _$AnswerRecordImpl({
    required this.questionId,
    required this.selectedAnswer,
    required this.correctAnswer,
    required this.isCorrect,
  });

  factory _$AnswerRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnswerRecordImplFromJson(json);

  @override
  final String questionId;
  @override
  final int selectedAnswer;
  @override
  final int correctAnswer;
  @override
  final bool isCorrect;

  @override
  String toString() {
    return 'AnswerRecord(questionId: $questionId, selectedAnswer: $selectedAnswer, correctAnswer: $correctAnswer, isCorrect: $isCorrect)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnswerRecordImpl &&
            (identical(other.questionId, questionId) ||
                other.questionId == questionId) &&
            (identical(other.selectedAnswer, selectedAnswer) ||
                other.selectedAnswer == selectedAnswer) &&
            (identical(other.correctAnswer, correctAnswer) ||
                other.correctAnswer == correctAnswer) &&
            (identical(other.isCorrect, isCorrect) ||
                other.isCorrect == isCorrect));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    questionId,
    selectedAnswer,
    correctAnswer,
    isCorrect,
  );

  /// Create a copy of AnswerRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnswerRecordImplCopyWith<_$AnswerRecordImpl> get copyWith =>
      __$$AnswerRecordImplCopyWithImpl<_$AnswerRecordImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AnswerRecordImplToJson(this);
  }
}

abstract class _AnswerRecord implements AnswerRecord {
  const factory _AnswerRecord({
    required final String questionId,
    required final int selectedAnswer,
    required final int correctAnswer,
    required final bool isCorrect,
  }) = _$AnswerRecordImpl;

  factory _AnswerRecord.fromJson(Map<String, dynamic> json) =
      _$AnswerRecordImpl.fromJson;

  @override
  String get questionId;
  @override
  int get selectedAnswer;
  @override
  int get correctAnswer;
  @override
  bool get isCorrect;

  /// Create a copy of AnswerRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnswerRecordImplCopyWith<_$AnswerRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
