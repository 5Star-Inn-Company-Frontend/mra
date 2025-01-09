// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'powerValidate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PowerValidate _$PowerValidateFromJson(Map<String, dynamic> json) =>
    PowerValidate(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PowerValidateToJson(PowerValidate instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      provider: json['provider'] as String?,
      number: json['number'] as int?,
      type: json['type'] as String?,
      customerName: json['Customer_Name'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'provider': instance.provider,
      'number': instance.number,
      'type': instance.type,
      'Customer_Name': instance.customerName,
    };
