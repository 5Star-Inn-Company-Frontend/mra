import 'package:json_annotation/json_annotation.dart';

part 'buyData.g.dart';

@JsonSerializable()
class BuyData {
  BuyData({
    required this.number,
    required this.planId,
    required this.provider,
    required this.reference,
  });

  final String? number;

  @JsonKey(name: 'plan_id')
  final int? planId;
  final int? provider;
  final String? reference;

  factory BuyData.fromJson(Map<String, dynamic> json) =>
      _$BuyDataFromJson(json);

  Map<String, dynamic> toJson() => _$BuyDataToJson(this);
}
