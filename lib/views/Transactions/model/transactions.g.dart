// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transactions _$TransactionsFromJson(Map<String, dynamic> json) => Transactions(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TransactionsToJson(Transactions instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      id: json['id'] as int?,
      businessId: json['business_id'] as int?,
      userId: json['user_id'] as int?,
      uuid: json['uuid'] as String?,
      reference: json['reference'] as String?,
      type: json['type'] as String?,
      remark: json['remark'] as String?,
      amount: json['amount'] as String?,
      previous: json['previous'] as String?,
      balance: json['balance'] as String?,
      status: json['status'] as int?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      bills: json['bills'] == null
          ? null
          : Bills.fromJson(json['bills'] as Map<String, dynamic>),
      transfer: json['transfer'],
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'id': instance.id,
      'business_id': instance.businessId,
      'user_id': instance.userId,
      'uuid': instance.uuid,
      'reference': instance.reference,
      'type': instance.type,
      'remark': instance.remark,
      'amount': instance.amount,
      'previous': instance.previous,
      'balance': instance.balance,
      'status': instance.status,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'bills': instance.bills,
      'transfer': instance.transfer,
    };

Bills _$BillsFromJson(Map<String, dynamic> json) => Bills(
      id: json['id'] as int?,
      businessId: json['business_id'] as int?,
      userId: json['user_id'] as int?,
      serviceType: json['service_type'] as String?,
      provider: json['provider'] as String?,
      recipient: json['recipient'] as String?,
      amount: json['amount'] as String?,
      discount: json['discount'] as String?,
      fee: json['fee'] as String?,
      voucher: json['voucher'] as String?,
      paid: json['paid'] as String?,
      initBal: json['init_bal'] as String?,
      newBal: json['new_bal'] as String?,
      currency: json['currency'] as String?,
      trx: json['trx'] as String?,
      ref: json['ref'] as String?,
      apiReqId: json['api_req_id'] as String?,
      channel: json['channel'] as String?,
      domain: json['domain'] as String?,
      purchasedCode: json['purchased_code'],
      units: json['units'],
      status: json['status'] as String?,
      errorMsg: json['errorMsg'] as String?,
      refunded: json['refunded'] as int?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$BillsToJson(Bills instance) => <String, dynamic>{
      'id': instance.id,
      'business_id': instance.businessId,
      'user_id': instance.userId,
      'service_type': instance.serviceType,
      'provider': instance.provider,
      'recipient': instance.recipient,
      'amount': instance.amount,
      'discount': instance.discount,
      'fee': instance.fee,
      'voucher': instance.voucher,
      'paid': instance.paid,
      'init_bal': instance.initBal,
      'new_bal': instance.newBal,
      'currency': instance.currency,
      'trx': instance.trx,
      'ref': instance.ref,
      'api_req_id': instance.apiReqId,
      'channel': instance.channel,
      'domain': instance.domain,
      'purchased_code': instance.purchasedCode,
      'units': instance.units,
      'status': instance.status,
      'errorMsg': instance.errorMsg,
      'refunded': instance.refunded,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
