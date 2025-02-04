import 'dart:convert';

class TransactionModel {
  final bool status;
  final String message;
  final List<Transaction> data;

  TransactionModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) => TransactionModel(
    status: json["status"],
    message: json["message"],
    data: List<Transaction>.from(json["data"].map((x) => Transaction.fromJson(x))),
  );
}

class Transaction {
  final int id;
  final int userId;
  final String title;
  final int amount;
  final int charges;
  final double commission;
  final String reference;
  final String recipient;
  final String type;
  final String transactionType;
  final String remark;
  final String prevBalance;
  final String newBalance;
  final DateTime createdAt;
  final DateTime updatedAt;

  Transaction({
    required this.id,
    required this.userId,
    required this.title,
    required this.amount,
    required this.charges,
    required this.commission,
    required this.reference,
    required this.recipient,
    required this.type,
    required this.transactionType,
    required this.remark,
    required this.prevBalance,
    required this.newBalance,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    id: json["id"],
    userId: json["user_id"],
    title: json["title"],
    amount: json["amount"],
    charges: json["charges"],
    commission: json["commission"].toDouble(),
    reference: json["reference"],
    recipient: json["recipient"],
    type: json["type"],
    transactionType: json["transaction_type"],
    remark: json["remark"],
    prevBalance: json["prev_balance"],
    newBalance: json["new_balance"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );
}
