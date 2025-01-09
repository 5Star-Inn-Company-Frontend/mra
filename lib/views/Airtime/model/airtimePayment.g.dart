// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'airtimePayment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AirtimePayment _$AirtimePaymentFromJson(Map<String, dynamic> json) =>
    AirtimePayment(
      amount: json['amount'] as int?,
      number: json['number'] as String?,
      provider: json['provider'] as String?,
      reference: json['reference'] as String?,
    );

Map<String, dynamic> _$AirtimePaymentToJson(AirtimePayment instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'number': instance.number,
      'provider': instance.provider,
      'reference': instance.reference,
    };
