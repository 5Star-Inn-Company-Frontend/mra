// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_transfer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountTransfer _$AccountTransferFromJson(Map<String, dynamic> json) =>
    AccountTransfer(
      accountNumber: json['account_number'] as String?,
      bankCode: json['bank_code'] as String?,
      amount: json['amount'] as int?,
      narration: json['narration'] as String?,
      reference: json['reference'] as String?,
      pin: json['pin'] as String?,
      accountName: json['accountName'] as String?,
    );

Map<String, dynamic> _$AccountTransferToJson(AccountTransfer instance) =>
    <String, dynamic>{
      'account_number': instance.accountNumber,
      'bank_code': instance.bankCode,
      'amount': instance.amount,
      'narration': instance.narration,
      'reference': instance.reference,
      'pin': instance.pin,
      'accountName': instance.accountName,
    };
