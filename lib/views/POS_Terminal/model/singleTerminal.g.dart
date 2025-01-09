// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'singleTerminal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TerminalTransactions _$TerminalTransactionsFromJson(
        Map<String, dynamic> json) =>
    TerminalTransactions(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      datas: json['datas'] == null
          ? null
          : Datas.fromJson(json['datas'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TerminalTransactionsToJson(
        TerminalTransactions instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'datas': instance.datas,
    };

Datas _$DatasFromJson(Map<String, dynamic> json) => Datas(
      transactions: json['transactions'] == null
          ? null
          : Transactions.fromJson(json['transactions'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DatasToJson(Datas instance) => <String, dynamic>{
      'transactions': instance.transactions,
    };

Transactions _$TransactionsFromJson(Map<String, dynamic> json) => Transactions(
      list: (json['list'] as List<dynamic>?)
          ?.map((e) => ListElement.fromJson(e as Map<String, dynamic>))
          .toList(),
      page: json['page'] as int?,
      size: json['size'] as int?,
      total: json['total'] as int?,
    );

Map<String, dynamic> _$TransactionsToJson(Transactions instance) =>
    <String, dynamic>{
      'list': instance.list,
      'page': instance.page,
      'size': instance.size,
      'total': instance.total,
    };

ListElement _$ListElementFromJson(Map<String, dynamic> json) => ListElement(
      reference: json['reference'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      transactionType: json['transactionType'] as String?,
      balance: (json['balance'] as num?)?.toDouble(),
      timeCreated: json['timeCreated'] as String?,
    );

Map<String, dynamic> _$ListElementToJson(ListElement instance) =>
    <String, dynamic>{
      'reference': instance.reference,
      'amount': instance.amount,
      'transactionType': instance.transactionType,
      'balance': instance.balance,
      'timeCreated': instance.timeCreated,
    };
