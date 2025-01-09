// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'changePassword.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdatePassword _$UpdatePasswordFromJson(Map<String, dynamic> json) =>
    UpdatePassword(
      current: json['current'] as String?,
      updatePasswordNew: json['updatePasswordNew'] as String?,
    );

Map<String, dynamic> _$UpdatePasswordToJson(UpdatePassword instance) =>
    <String, dynamic>{
      'current': instance.current,
      'updatePasswordNew': instance.updatePasswordNew,
    };
