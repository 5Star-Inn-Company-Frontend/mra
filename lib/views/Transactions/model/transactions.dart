import 'package:json_annotation/json_annotation.dart';

part 'transactions.g.dart';

@JsonSerializable()
class Transactions {
  Transactions({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final List<Datum>? data;

  factory Transactions.fromJson(Map<String, dynamic> json) =>
      _$TransactionsFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionsToJson(this);
}

@JsonSerializable()
class Datum {
  Datum({
    required this.id,
    required this.businessId,
    required this.userId,
    required this.uuid,
    required this.reference,
    required this.type,
    required this.remark,
    required this.amount,
    required this.previous,
    required this.balance,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.bills,
    required this.transfer,
  });

  final int? id;

  @JsonKey(name: 'business_id')
  final int? businessId;

  @JsonKey(name: 'user_id')
  final int? userId;
  final String? uuid;
  final String? reference;
  final String? type;
  final String? remark;
  final String? amount;
  final String? previous;
  final String? balance;
  final int? status;

  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  final Bills? bills;
  final dynamic transfer;

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}

@JsonSerializable()
class Bills {
  Bills({
    required this.id,
    required this.businessId,
    required this.userId,
    required this.serviceType,
    required this.provider,
    required this.recipient,
    required this.amount,
    required this.discount,
    required this.fee,
    required this.voucher,
    required this.paid,
    required this.initBal,
    required this.newBal,
    required this.currency,
    required this.trx,
    required this.ref,
    required this.apiReqId,
    required this.channel,
    required this.domain,
    required this.purchasedCode,
    required this.units,
    required this.status,
    required this.errorMsg,
    required this.refunded,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;

  @JsonKey(name: 'business_id')
  final int? businessId;

  @JsonKey(name: 'user_id')
  final int? userId;

  @JsonKey(name: 'service_type')
  final String? serviceType;
  final String? provider;
  final String? recipient;
  final String? amount;
  final String? discount;
  final String? fee;
  final String? voucher;
  final String? paid;

  @JsonKey(name: 'init_bal')
  final String? initBal;

  @JsonKey(name: 'new_bal')
  final String? newBal;
  final String? currency;
  final String? trx;
  final String? ref;

  @JsonKey(name: 'api_req_id')
  final String? apiReqId;
  final String? channel;
  final String? domain;

  @JsonKey(name: 'purchased_code')
  final dynamic purchasedCode;
  final dynamic units;
  final String? status;
  final String? errorMsg;
  final int? refunded;

  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  factory Bills.fromJson(Map<String, dynamic> json) => _$BillsFromJson(json);

  Map<String, dynamic> toJson() => _$BillsToJson(this);
}
