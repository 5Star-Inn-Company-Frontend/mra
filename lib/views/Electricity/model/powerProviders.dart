import 'package:json_annotation/json_annotation.dart';

part 'powerProviders.g.dart';

@JsonSerializable()
class PowerProviders {
  PowerProviders({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final List<Datum>? data;

  factory PowerProviders.fromJson(Map<String, dynamic> json) =>
      _$PowerProvidersFromJson(json);

  Map<String, dynamic> toJson() => _$PowerProvidersToJson(this);
}

@JsonSerializable()
class Datum {
  Datum({
    required this.provider,
    required this.code,
    required this.providerLogoUrl,
    required this.minAmount,
  });

  final String? provider;
  final String? code;
  final String? providerLogoUrl;
  final String? minAmount;

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}
