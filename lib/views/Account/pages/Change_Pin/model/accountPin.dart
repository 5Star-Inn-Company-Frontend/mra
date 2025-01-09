import 'package:json_annotation/json_annotation.dart';

part 'accountPin.g.dart';

@JsonSerializable()
class AccountPin {
  AccountPin({
    required this.current,
    required this.accountPinNew,
  });

  final String? current;
  final String? accountPinNew;

  AccountPin copyWith({
    String? current,
    String? accountPinNew,
  }) {
    return AccountPin(
      current: current ?? this.current,
      accountPinNew: accountPinNew ?? this.accountPinNew,
    );
  }

  factory AccountPin.fromJson(Map<String, dynamic> json) =>
      _$AccountPinFromJson(json);

  Map<String, dynamic> toJson() => _$AccountPinToJson(this);

  @override
  String toString() {
    return "$current, $accountPinNew, ";
  }
}
