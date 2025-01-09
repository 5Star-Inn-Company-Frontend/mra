// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validateCableSub.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValidateCableSub _$ValidateCableSubFromJson(Map<String, dynamic> json) =>
    ValidateCableSub(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ValidateCableSubToJson(ValidateCableSub instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      provider: json['provider'] as String?,
      number: json['number'] as int?,
      customerName: json['Customer_Name'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'provider': instance.provider,
      'number': instance.number,
      'Customer_Name': instance.customerName,
    };
