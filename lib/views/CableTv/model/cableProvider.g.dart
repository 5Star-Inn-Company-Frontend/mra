// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cableProvider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CableProvide _$CableProvideFromJson(Map<String, dynamic> json) => CableProvide(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CableProvideToJson(CableProvide instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      provider: json['provider'] as String?,
      providerLogoUrl: json['providerLogoUrl'] as String?,
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'provider': instance.provider,
      'providerLogoUrl': instance.providerLogoUrl,
    };
