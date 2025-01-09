// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'powerPayment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PowerPayment _$PowerPaymentFromJson(Map<String, dynamic> json) => PowerPayment(
      amount: json['amount'] as int?,
      code: json['code'] as String?,
      number: json['number'] as int?,
      provider: json['provider'] as String?,
      reference: json['reference'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$PowerPaymentToJson(PowerPayment instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'code': instance.code,
      'number': instance.number,
      'provider': instance.provider,
      'reference': instance.reference,
      'type': instance.type,
    };
