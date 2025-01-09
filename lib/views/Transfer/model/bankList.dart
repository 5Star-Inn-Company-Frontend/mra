import 'package:json_annotation/json_annotation.dart';

part 'bankList.g.dart';

@JsonSerializable()
class BankList {
  BankList({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final List<Datum>? data;

  BankList copyWith({
    bool? success,
    String? message,
    List<Datum>? data,
  }) {
    return BankList(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  factory BankList.fromJson(Map<String, dynamic> json) =>
      _$BankListFromJson(json);

  Map<String, dynamic> toJson() => _$BankListToJson(this);

  @override
  String toString() {
    return "$success, $message, $data, ";
  }
}

@JsonSerializable()
class Datum {
  Datum({
    required this.url,
    required this.name,
    required this.code,
  });

  final String? url;
  final String? name;
  final String? code;

  Datum copyWith({
    String? url,
    String? name,
    String? code,
  }) {
    return Datum(
      url: url ?? this.url,
      name: name ?? this.name,
      code: code ?? this.code,
    );
  }

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);

  @override
  String toString() {
    return "$url, $name, $code, ";
  }
}
