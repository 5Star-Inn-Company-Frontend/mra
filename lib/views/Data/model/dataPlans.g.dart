// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dataPlans.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataPlans _$DataPlansFromJson(Map<String, dynamic> json) => DataPlans(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataPlansToJson(DataPlans instance) => <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      id: json['id'] as int?,
      name: json['name'] as String?,
      amount: json['amount'] as String?,
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'amount': instance.amount,
    };
