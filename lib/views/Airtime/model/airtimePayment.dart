import 'package:json_annotation/json_annotation.dart';

part 'airtimePayment.g.dart';

@JsonSerializable()
class AirtimePayment {
  AirtimePayment({
    required this.amount,
    required this.number,
    required this.provider,
    required this.reference,
  });

  final int? amount;
  final String? number;
  final String? provider;
  final String? reference;

  factory AirtimePayment.fromJson(Map<String, dynamic> json) =>
      _$AirtimePaymentFromJson(json);

  Map<String, dynamic> toJson() => _$AirtimePaymentToJson(this);
}
