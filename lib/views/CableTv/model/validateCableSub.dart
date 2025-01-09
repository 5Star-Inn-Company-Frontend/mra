import 'package:json_annotation/json_annotation.dart';

part 'validateCableSub.g.dart';

@JsonSerializable()
class ValidateCableSub {
  ValidateCableSub({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory ValidateCableSub.fromJson(Map<String, dynamic> json) =>
      _$ValidateCableSubFromJson(json);

  Map<String, dynamic> toJson() => _$ValidateCableSubToJson(this);
}

@JsonSerializable()
class Data {
  Data({
    required this.provider,
    required this.number,
    required this.customerName,
  });

  final String? provider;
  final int? number;

  @JsonKey(name: 'Customer_Name')
  final String? customerName;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
