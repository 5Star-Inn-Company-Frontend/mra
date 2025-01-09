import 'package:json_annotation/json_annotation.dart';

part 'verifybankAccount.g.dart';

@JsonSerializable()
class VerifyBankAccount {
  VerifyBankAccount({
    required this.accountNumber,
    required this.bankCode,
  });

  @JsonKey(name: 'account_number')
  final String? accountNumber;

  @JsonKey(name: 'bank_code')
  final String? bankCode;

  factory VerifyBankAccount.fromJson(Map<String, dynamic> json) =>
      _$VerifyBankAccountFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyBankAccountToJson(this);
}
