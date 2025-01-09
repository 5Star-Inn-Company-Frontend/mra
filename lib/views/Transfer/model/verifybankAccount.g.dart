// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verifybankAccount.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyBankAccount _$VerifyBankAccountFromJson(Map<String, dynamic> json) =>
    VerifyBankAccount(
      accountNumber: json['account_number'] as String?,
      bankCode: json['bank_code'] as String?,
    );

Map<String, dynamic> _$VerifyBankAccountToJson(VerifyBankAccount instance) =>
    <String, dynamic>{
      'account_number': instance.accountNumber,
      'bank_code': instance.bankCode,
    };
