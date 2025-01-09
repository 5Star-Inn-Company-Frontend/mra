import 'package:json_annotation/json_annotation.dart';

part 'notifications.g.dart';

@JsonSerializable()
class NotificationsModel {
  NotificationsModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final int? success;
  final String? message;
  final List<Datum>? data;

  NotificationsModel copyWith({
    int? success,
    String? message,
    List<Datum>? data,
  }) {
    return NotificationsModel(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  factory NotificationsModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationsModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationsModelToJson(this);

  @override
  String toString() {
    return "$success, $message, $data, ";
  }
}

@JsonSerializable()
class Datum {
  Datum({
    required this.id,
    required this.type,
    required this.notifiableType,
    required this.notifiableId,
    required this.isExpanded,
    required this.data,
    required this.readAt,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? type;

  @JsonKey(name: 'notifiable_type')
  final String? notifiableType;

  @JsonKey(name: 'notifiable_id')
  final int? notifiableId;
  late final bool? isExpanded;
  final Data? data;

  @JsonKey(name: 'read_at')
  final dynamic readAt;

  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  Datum copyWith({
    String? id,
    String? type,
    String? notifiableType,
    int? notifiableId,
    bool? isExpanded,
    Data? data,
    dynamic readAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Datum(
      id: id ?? this.id,
      type: type ?? this.type,
      notifiableType: notifiableType ?? this.notifiableType,
      notifiableId: notifiableId ?? this.notifiableId,
      isExpanded: isExpanded ?? this.isExpanded,
      data: data ?? this.data,
      readAt: readAt ?? this.readAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);

  @override
  String toString() {
    return "$id, $type, $notifiableType, $notifiableId, $isExpanded, $data, $readAt, $createdAt, $updatedAt, ";
  }
}

@JsonSerializable()
class Data {
  Data({
    required this.sender,
    required this.message,
  });

  final String? sender;
  final String? message;

  Data copyWith({
    String? sender,
    String? message,
  }) {
    return Data(
      sender: sender ?? this.sender,
      message: message ?? this.message,
    );
  }

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);

  @override
  String toString() {
    return "$sender, $message, ";
  }
}
