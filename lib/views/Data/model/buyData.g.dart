// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buyData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuyData _$BuyDataFromJson(Map<String, dynamic> json) => BuyData(
      number: json['number'] as String?,
      planId: json['plan_id'] as int?,
      provider: json['provider'] as int?,
      reference: json['reference'] as String?,
    );

Map<String, dynamic> _$BuyDataToJson(BuyData instance) => <String, dynamic>{
      'number': instance.number,
      'plan_id': instance.planId,
      'provider': instance.provider,
      'reference': instance.reference,
    };
