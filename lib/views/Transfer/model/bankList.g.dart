// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bankList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankList _$BankListFromJson(Map<String, dynamic> json) => BankList(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BankListToJson(BankList instance) => <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      url: json['url'] as String?,
      name: json['name'] as String?,
      code: json['code'] as String?,
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'url': instance.url,
      'name': instance.name,
      'code': instance.code,
    };
