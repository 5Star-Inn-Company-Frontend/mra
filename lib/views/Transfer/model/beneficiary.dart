import 'package:json_annotation/json_annotation.dart';

part 'beneficiary.g.dart';

@JsonSerializable()
class Beneficiary {
  Beneficiary({
    required this.name,
    required this.accountNumber,
    required this.bankName,
    required this.bankCode,
  });

  final String? name;
  final String? accountNumber;
  final String? bankName;
  final String? bankCode;

  factory Beneficiary.fromJson(Map<String, dynamic> json) =>
      _$BeneficiaryFromJson(json);

  Map<String, dynamic> toJson() => _$BeneficiaryToJson(this);
}
