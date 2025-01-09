import 'package:json_annotation/json_annotation.dart';

part 'cablePayment.g.dart';

@JsonSerializable()
class CablePayment {
  CablePayment({
    required this.code,
    required this.number,
    required this.provider,
    required this.reference,
  });

  final String? code;
  final int? number;
  final String? provider;
  final String? reference;

  factory CablePayment.fromJson(Map<String, dynamic> json) =>
      _$CablePaymentFromJson(json);

  Map<String, dynamic> toJson() => _$CablePaymentToJson(this);
}
