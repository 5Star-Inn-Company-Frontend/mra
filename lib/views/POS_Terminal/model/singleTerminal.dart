import 'package:json_annotation/json_annotation.dart';

part 'singleTerminal.g.dart';

@JsonSerializable()
class TerminalTransactions {
  TerminalTransactions({
    required this.status,
    required this.message,
    required this.datas,
  });

  final bool? status;
  final String? message;
  final Datas? datas;

  TerminalTransactions copyWith({
    bool? status,
    String? message,
    Datas? datas,
  }) {
    return TerminalTransactions(
      status: status ?? this.status,
      message: message ?? this.message,
      datas: datas ?? this.datas,
    );
  }

  factory TerminalTransactions.fromJson(Map<String, dynamic> json) =>
      _$TerminalTransactionsFromJson(json);

  Map<String, dynamic> toJson() => _$TerminalTransactionsToJson(this);

  @override
  String toString() {
    return "$status, $message, $datas, ";
  }
}

@JsonSerializable()
class Datas {
  Datas({
    required this.transactions,
  });

  final Transactions? transactions;

  Datas copyWith({
    Transactions? transactions,
  }) {
    return Datas(
      transactions: transactions ?? this.transactions,
    );
  }

  factory Datas.fromJson(Map<String, dynamic> json) => _$DatasFromJson(json);

  Map<String, dynamic> toJson() => _$DatasToJson(this);

  @override
  String toString() {
    return "$transactions, ";
  }
}

@JsonSerializable()
class Transactions {
  Transactions({
    required this.list,
    required this.page,
    required this.size,
    required this.total,
  });

  final List<ListElement>? list;
  final int? page;
  final int? size;
  final int? total;

  Transactions copyWith({
    List<ListElement>? list,
    int? page,
    int? size,
    int? total,
  }) {
    return Transactions(
      list: list ?? this.list,
      page: page ?? this.page,
      size: size ?? this.size,
      total: total ?? this.total,
    );
  }

  factory Transactions.fromJson(Map<String, dynamic> json) =>
      _$TransactionsFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionsToJson(this);

  @override
  String toString() {
    return "$list, $page, $size, $total, ";
  }
}

@JsonSerializable()
class ListElement {
  ListElement({
    required this.reference,
    required this.amount,
    required this.transactionType,
    required this.balance,
    required this.timeCreated,
  });

  final String? reference;
  final double? amount;
  final String? transactionType;
  final double? balance;
  final String? timeCreated;

  ListElement copyWith({
    String? reference,
    double? amount,
    String? transactionType,
    double? balance,
    String? timeCreated,
  }) {
    return ListElement(
      reference: reference ?? this.reference,
      amount: amount ?? this.amount,
      transactionType: transactionType ?? this.transactionType,
      balance: balance ?? this.balance,
      timeCreated: timeCreated ?? this.timeCreated,
    );
  }

  factory ListElement.fromJson(Map<String, dynamic> json) =>
      _$ListElementFromJson(json);

  Map<String, dynamic> toJson() => _$ListElementToJson(this);

  @override
  String toString() {
    return "$reference, $amount, $transactionType, $balance, $timeCreated, ";
  }
}
