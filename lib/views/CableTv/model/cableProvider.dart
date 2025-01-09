import 'package:json_annotation/json_annotation.dart';

part 'cableProvider.g.dart';

@JsonSerializable()
class CableProvide {
  CableProvide({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final List<Datum>? data;

  factory CableProvide.fromJson(Map<String, dynamic> json) =>
      _$CableProvideFromJson(json);

  Map<String, dynamic> toJson() => _$CableProvideToJson(this);
}

@JsonSerializable()
class Datum {
  Datum({
    required this.provider,
    required this.providerLogoUrl,
  });

  final String? provider;
  final String? providerLogoUrl;

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}
