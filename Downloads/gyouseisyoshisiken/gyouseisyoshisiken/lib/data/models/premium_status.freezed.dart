// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'premium_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PremiumStatus _$PremiumStatusFromJson(Map<String, dynamic> json) {
  return _PremiumStatus.fromJson(json);
}

/// @nodoc
mixin _$PremiumStatus {
  /// プレミアム有効フラグ
  bool get isPremium => throw _privateConstructorUsedError;

  /// 購入種別
  PremiumPurchaseType get purchaseType => throw _privateConstructorUsedError;

  /// 有効期限（サブスクの場合）
  DateTime? get expiryDate => throw _privateConstructorUsedError;

  /// 旧バージョンからの移行済みフラグ
  bool get isLegacyMigrated => throw _privateConstructorUsedError;

  /// 購入日時
  DateTime? get purchasedAt => throw _privateConstructorUsedError;

  /// Serializes this PremiumStatus to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PremiumStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PremiumStatusCopyWith<PremiumStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PremiumStatusCopyWith<$Res> {
  factory $PremiumStatusCopyWith(
    PremiumStatus value,
    $Res Function(PremiumStatus) then,
  ) = _$PremiumStatusCopyWithImpl<$Res, PremiumStatus>;
  @useResult
  $Res call({
    bool isPremium,
    PremiumPurchaseType purchaseType,
    DateTime? expiryDate,
    bool isLegacyMigrated,
    DateTime? purchasedAt,
  });
}

/// @nodoc
class _$PremiumStatusCopyWithImpl<$Res, $Val extends PremiumStatus>
    implements $PremiumStatusCopyWith<$Res> {
  _$PremiumStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PremiumStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isPremium = null,
    Object? purchaseType = null,
    Object? expiryDate = freezed,
    Object? isLegacyMigrated = null,
    Object? purchasedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            isPremium: null == isPremium
                ? _value.isPremium
                : isPremium // ignore: cast_nullable_to_non_nullable
                      as bool,
            purchaseType: null == purchaseType
                ? _value.purchaseType
                : purchaseType // ignore: cast_nullable_to_non_nullable
                      as PremiumPurchaseType,
            expiryDate: freezed == expiryDate
                ? _value.expiryDate
                : expiryDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            isLegacyMigrated: null == isLegacyMigrated
                ? _value.isLegacyMigrated
                : isLegacyMigrated // ignore: cast_nullable_to_non_nullable
                      as bool,
            purchasedAt: freezed == purchasedAt
                ? _value.purchasedAt
                : purchasedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PremiumStatusImplCopyWith<$Res>
    implements $PremiumStatusCopyWith<$Res> {
  factory _$$PremiumStatusImplCopyWith(
    _$PremiumStatusImpl value,
    $Res Function(_$PremiumStatusImpl) then,
  ) = __$$PremiumStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isPremium,
    PremiumPurchaseType purchaseType,
    DateTime? expiryDate,
    bool isLegacyMigrated,
    DateTime? purchasedAt,
  });
}

/// @nodoc
class __$$PremiumStatusImplCopyWithImpl<$Res>
    extends _$PremiumStatusCopyWithImpl<$Res, _$PremiumStatusImpl>
    implements _$$PremiumStatusImplCopyWith<$Res> {
  __$$PremiumStatusImplCopyWithImpl(
    _$PremiumStatusImpl _value,
    $Res Function(_$PremiumStatusImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PremiumStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isPremium = null,
    Object? purchaseType = null,
    Object? expiryDate = freezed,
    Object? isLegacyMigrated = null,
    Object? purchasedAt = freezed,
  }) {
    return _then(
      _$PremiumStatusImpl(
        isPremium: null == isPremium
            ? _value.isPremium
            : isPremium // ignore: cast_nullable_to_non_nullable
                  as bool,
        purchaseType: null == purchaseType
            ? _value.purchaseType
            : purchaseType // ignore: cast_nullable_to_non_nullable
                  as PremiumPurchaseType,
        expiryDate: freezed == expiryDate
            ? _value.expiryDate
            : expiryDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        isLegacyMigrated: null == isLegacyMigrated
            ? _value.isLegacyMigrated
            : isLegacyMigrated // ignore: cast_nullable_to_non_nullable
                  as bool,
        purchasedAt: freezed == purchasedAt
            ? _value.purchasedAt
            : purchasedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PremiumStatusImpl extends _PremiumStatus {
  const _$PremiumStatusImpl({
    this.isPremium = false,
    this.purchaseType = PremiumPurchaseType.none,
    this.expiryDate,
    this.isLegacyMigrated = false,
    this.purchasedAt,
  }) : super._();

  factory _$PremiumStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$PremiumStatusImplFromJson(json);

  /// プレミアム有効フラグ
  @override
  @JsonKey()
  final bool isPremium;

  /// 購入種別
  @override
  @JsonKey()
  final PremiumPurchaseType purchaseType;

  /// 有効期限（サブスクの場合）
  @override
  final DateTime? expiryDate;

  /// 旧バージョンからの移行済みフラグ
  @override
  @JsonKey()
  final bool isLegacyMigrated;

  /// 購入日時
  @override
  final DateTime? purchasedAt;

  @override
  String toString() {
    return 'PremiumStatus(isPremium: $isPremium, purchaseType: $purchaseType, expiryDate: $expiryDate, isLegacyMigrated: $isLegacyMigrated, purchasedAt: $purchasedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PremiumStatusImpl &&
            (identical(other.isPremium, isPremium) ||
                other.isPremium == isPremium) &&
            (identical(other.purchaseType, purchaseType) ||
                other.purchaseType == purchaseType) &&
            (identical(other.expiryDate, expiryDate) ||
                other.expiryDate == expiryDate) &&
            (identical(other.isLegacyMigrated, isLegacyMigrated) ||
                other.isLegacyMigrated == isLegacyMigrated) &&
            (identical(other.purchasedAt, purchasedAt) ||
                other.purchasedAt == purchasedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    isPremium,
    purchaseType,
    expiryDate,
    isLegacyMigrated,
    purchasedAt,
  );

  /// Create a copy of PremiumStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PremiumStatusImplCopyWith<_$PremiumStatusImpl> get copyWith =>
      __$$PremiumStatusImplCopyWithImpl<_$PremiumStatusImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PremiumStatusImplToJson(this);
  }
}

abstract class _PremiumStatus extends PremiumStatus {
  const factory _PremiumStatus({
    final bool isPremium,
    final PremiumPurchaseType purchaseType,
    final DateTime? expiryDate,
    final bool isLegacyMigrated,
    final DateTime? purchasedAt,
  }) = _$PremiumStatusImpl;
  const _PremiumStatus._() : super._();

  factory _PremiumStatus.fromJson(Map<String, dynamic> json) =
      _$PremiumStatusImpl.fromJson;

  /// プレミアム有効フラグ
  @override
  bool get isPremium;

  /// 購入種別
  @override
  PremiumPurchaseType get purchaseType;

  /// 有効期限（サブスクの場合）
  @override
  DateTime? get expiryDate;

  /// 旧バージョンからの移行済みフラグ
  @override
  bool get isLegacyMigrated;

  /// 購入日時
  @override
  DateTime? get purchasedAt;

  /// Create a copy of PremiumStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PremiumStatusImplCopyWith<_$PremiumStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
