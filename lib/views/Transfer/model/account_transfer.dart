import 'package:json_annotation/json_annotation.dart';

part 'accountTransfer.g.dart';

@JsonSerializable()
class AccountTransfer {
  AccountTransfer({
    required this.accountNumber,
    required this.bankCode,
    required this.amount,
    required this.narration,
    required this.reference,
    required this.pin,
    required this.accountName,
  });

  @JsonKey(name: 'account_number')
  final String? accountNumber;

  @JsonKey(name: 'bank_code')
  final String? bankCode;
  final int? amount;
  final String? narration;
  final String? reference;
  final String? pin;
  final String? accountName;

  factory AccountTransfer.fromJson(Map<String, dynamic> json) =>
      _$AccountTransferFromJson(json);

  Map<String, dynamic> toJson() => _$AccountTransferToJson(this);
}
