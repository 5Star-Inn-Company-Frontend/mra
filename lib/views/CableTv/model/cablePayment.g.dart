// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cablePayment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CablePayment _$CablePaymentFromJson(Map<String, dynamic> json) => CablePayment(
      code: json['code'] as String?,
      number: json['number'] as int?,
      provider: json['provider'] as String?,
      reference: json['reference'] as String?,
    );

Map<String, dynamic> _$CablePaymentToJson(CablePayment instance) =>
    <String, dynamic>{
      'code': instance.code,
      'number': instance.number,
      'provider': instance.provider,
      'reference': instance.reference,
    };
