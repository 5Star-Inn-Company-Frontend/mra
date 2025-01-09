import 'package:json_annotation/json_annotation.dart';

part 'airtimeProvider.g.dart';

@JsonSerializable()
class AirtimeProviders {
  AirtimeProviders({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final List<Datum>? data;

  factory AirtimeProviders.fromJson(Map<String, dynamic> json) =>
      _$AirtimeProvidersFromJson(json);

  Map<String, dynamic> toJson() => _$AirtimeProvidersToJson(this);
}

@JsonSerializable()
class Datum {
  Datum({
    required this.provider,
    required this.providerLogoUrl,
    required this.minAmount,
    required this.maxAmount,
  });

  final String? provider;
  final String? providerLogoUrl;
  final String? minAmount;
  final String? maxAmount;

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}
