import 'package:json_annotation/json_annotation.dart';

part 'walletResponse.g.dart';

@JsonSerializable()
class Wallet {
  Wallet({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final List<Datum>? data;

  factory Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);

  Map<String, dynamic> toJson() => _$WalletToJson(this);
}

@JsonSerializable()
class Datum {
  Datum({
    required this.id,
    required this.userId,
    required this.name,
    required this.balance,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;

  @JsonKey(name: 'user_id')
  final int? userId;
  final String? name;
  final int? balance;
  final int? status;

  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}
