import 'package:json_annotation/json_annotation.dart';

part 'cablePlans.g.dart';

@JsonSerializable()
class CablePlans {
  CablePlans({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final List<Datum>? data;

  factory CablePlans.fromJson(Map<String, dynamic> json) =>
      _$CablePlansFromJson(json);

  Map<String, dynamic> toJson() => _$CablePlansToJson(this);
}

@JsonSerializable()
class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.code,
    required this.amount,
    required this.cCent,
  });

  final int? id;
  final String? name;
  final String? code;
  final String? amount;

  @JsonKey(name: 'c_cent')
  final String? cCent;

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}
