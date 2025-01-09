import 'package:json_annotation/json_annotation.dart';

part 'dataProviders.g.dart';

@JsonSerializable()
class DataProviders {
  DataProviders({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final List<Datum>? data;

  factory DataProviders.fromJson(Map<String, dynamic> json) =>
      _$DataProvidersFromJson(json);

  Map<String, dynamic> toJson() => _$DataProvidersToJson(this);
}

@JsonSerializable()
class Datum {
  Datum({
    required this.id,
    required this.provider,
    required this.providerLogoUrl,
  });

  final int? id;
  final String? provider;
  final String? providerLogoUrl;

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}
