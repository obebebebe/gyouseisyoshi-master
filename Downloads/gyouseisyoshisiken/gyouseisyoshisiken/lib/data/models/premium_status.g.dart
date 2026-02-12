// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'premium_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PremiumStatusImpl _$$PremiumStatusImplFromJson(Map<String, dynamic> json) =>
    _$PremiumStatusImpl(
      isPremium: json['isPremium'] as bool? ?? false,
      purchaseType:
          $enumDecodeNullable(
            _$PremiumPurchaseTypeEnumMap,
            json['purchaseType'],
          ) ??
          PremiumPurchaseType.none,
      expiryDate: json['expiryDate'] == null
          ? null
          : DateTime.parse(json['expiryDate'] as String),
      isLegacyMigrated: json['isLegacyMigrated'] as bool? ?? false,
      purchasedAt: json['purchasedAt'] == null
          ? null
          : DateTime.parse(json['purchasedAt'] as String),
    );

Map<String, dynamic> _$$PremiumStatusImplToJson(_$PremiumStatusImpl instance) =>
    <String, dynamic>{
      'isPremium': instance.isPremium,
      'purchaseType': _$PremiumPurchaseTypeEnumMap[instance.purchaseType]!,
      'expiryDate': instance.expiryDate?.toIso8601String(),
      'isLegacyMigrated': instance.isLegacyMigrated,
      'purchasedAt': instance.purchasedAt?.toIso8601String(),
    };

const _$PremiumPurchaseTypeEnumMap = {
  PremiumPurchaseType.none: 'none',
  PremiumPurchaseType.oneTime: 'oneTime',
  PremiumPurchaseType.monthly: 'monthly',
  PremiumPurchaseType.yearly: 'yearly',
  PremiumPurchaseType.legacy: 'legacy',
};
