// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cablePlans.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CablePlans _$CablePlansFromJson(Map<String, dynamic> json) => CablePlans(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CablePlansToJson(CablePlans instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      id: json['id'] as int?,
      name: json['name'] as String?,
      code: json['code'] as String?,
      amount: json['amount'] as String?,
      cCent: json['c_cent'] as String?,
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'amount': instance.amount,
      'c_cent': instance.cCent,
    };
