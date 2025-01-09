import 'package:json_annotation/json_annotation.dart';

part 'powerValidate.g.dart';

@JsonSerializable()
class PowerValidate {
  PowerValidate({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory PowerValidate.fromJson(Map<String, dynamic> json) =>
      _$PowerValidateFromJson(json);

  Map<String, dynamic> toJson() => _$PowerValidateToJson(this);
}

@JsonSerializable()
class Data {
  Data({
    required this.provider,
    required this.number,
    required this.type,
    required this.customerName,
  });

  final String? provider;
  final int? number;
  final String? type;

  @JsonKey(name: 'Customer_Name')
  final String? customerName;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
