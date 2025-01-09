// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'airtimeProvider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AirtimeProviders _$AirtimeProvidersFromJson(Map<String, dynamic> json) =>
    AirtimeProviders(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AirtimeProvidersToJson(AirtimeProviders instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      provider: json['provider'] as String?,
      providerLogoUrl: json['providerLogoUrl'] as String?,
      minAmount: json['minAmount'] as String?,
      maxAmount: json['maxAmount'] as String?,
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'provider': instance.provider,
      'providerLogoUrl': instance.providerLogoUrl,
      'minAmount': instance.minAmount,
      'maxAmount': instance.maxAmount,
    };
