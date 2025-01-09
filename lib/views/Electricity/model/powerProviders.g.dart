// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'powerProviders.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PowerProviders _$PowerProvidersFromJson(Map<String, dynamic> json) =>
    PowerProviders(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PowerProvidersToJson(PowerProviders instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      provider: json['provider'] as String?,
      code: json['code'] as String?,
      providerLogoUrl: json['providerLogoUrl'] as String?,
      minAmount: json['minAmount'] as String?,
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'provider': instance.provider,
      'code': instance.code,
      'providerLogoUrl': instance.providerLogoUrl,
      'minAmount': instance.minAmount,
    };
