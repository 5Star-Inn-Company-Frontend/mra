import 'package:json_annotation/json_annotation.dart';

part 'terminal.g.dart';

@JsonSerializable()
class Terminal {
  Terminal({
    required this.status,
    required this.message,
    required this.datas,
  });

  final bool? status;
  final String? message;
  final List<Data>? datas;

  Terminal copyWith({
    bool? status,
    String? message,
    List<Data>? datas,
  }) {
    return Terminal(
      status: status ?? this.status,
      message: message ?? this.message,
      datas: datas ?? this.datas,
    );
  }

  factory Terminal.fromJson(Map<String, dynamic> json) =>
      _$TerminalFromJson(json);

  Map<String, dynamic> toJson() => _$TerminalToJson(this);

  @override
  String toString() {
    return "$status, $message, $datas, ";
  }
}

@JsonSerializable()
class Data {
  Data({
    required this.id,
    required this.businessId,
    required this.terminalId,
    required this.agentId,
    required this.subAgentId,
    required this.serialNumber,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;

  @JsonKey(name: 'business_id')
  final int? businessId;

  @JsonKey(name: 'terminal_id')
  final String? terminalId;

  @JsonKey(name: 'agent_id')
  final String? agentId;

  @JsonKey(name: 'sub_agent_id')
  final dynamic subAgentId;

  @JsonKey(name: 'serial_number')
  final String? serialNumber;
  final int? status;

  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  Data copyWith({
    int? id,
    int? businessId,
    String? terminalId,
    String? agentId,
    dynamic? subAgentId,
    String? serialNumber,
    int? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Data(
      id: id ?? this.id,
      businessId: businessId ?? this.businessId,
      terminalId: terminalId ?? this.terminalId,
      agentId: agentId ?? this.agentId,
      subAgentId: subAgentId ?? this.subAgentId,
      serialNumber: serialNumber ?? this.serialNumber,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);

  @override
  String toString() {
    return "$id, $businessId, $terminalId, $agentId, $subAgentId, $serialNumber, $status, $createdAt, $updatedAt, ";
  }
}
