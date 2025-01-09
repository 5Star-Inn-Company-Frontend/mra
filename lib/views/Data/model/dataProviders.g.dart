// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dataProviders.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataProviders _$DataProvidersFromJson(Map<String, dynamic> json) =>
    DataProviders(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataProvidersToJson(DataProviders instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      id: json['id'] as int?,
      provider: json['provider'] as String?,
      providerLogoUrl: json['providerLogoUrl'] as String?,
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'id': instance.id,
      'provider': instance.provider,
      'providerLogoUrl': instance.providerLogoUrl,
    };
