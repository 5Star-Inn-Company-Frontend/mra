import 'package:json_annotation/json_annotation.dart';

part 'powerPayment.g.dart';

@JsonSerializable()
class PowerPayment {
  PowerPayment({
    required this.amount,
    required this.code,
    required this.number,
    required this.provider,
    required this.reference,
    required this.type,
  });

  final int? amount;
  final String? code;
  final int? number;
  final String? provider;
  final String? reference;
  final String? type;

  factory PowerPayment.fromJson(Map<String, dynamic> json) =>
      _$PowerPaymentFromJson(json);

  Map<String, dynamic> toJson() => _$PowerPaymentToJson(this);
}
