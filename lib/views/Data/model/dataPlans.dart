import 'package:json_annotation/json_annotation.dart';

part 'dataPlans.g.dart';

@JsonSerializable()
class DataPlans {
  DataPlans({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final List<Datum>? data;

  factory DataPlans.fromJson(Map<String, dynamic> json) =>
      _$DataPlansFromJson(json);

  Map<String, dynamic> toJson() => _$DataPlansToJson(this);
}

@JsonSerializable()
class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.amount,
  });

  final int? id;
  final String? name;
  final String? amount;

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}
