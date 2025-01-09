// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'terminal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Terminal _$TerminalFromJson(Map<String, dynamic> json) => Terminal(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      datas: (json['datas'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TerminalToJson(Terminal instance) => <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'datas': instance.datas,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      id: json['id'] as int?,
      businessId: json['business_id'] as int?,
      terminalId: json['terminal_id'] as String?,
      agentId: json['agent_id'] as String?,
      subAgentId: json['sub_agent_id'],
      serialNumber: json['serial_number'] as String?,
      status: json['status'] as int?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'business_id': instance.businessId,
      'terminal_id': instance.terminalId,
      'agent_id': instance.agentId,
      'sub_agent_id': instance.subAgentId,
      'serial_number': instance.serialNumber,
      'status': instance.status,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
