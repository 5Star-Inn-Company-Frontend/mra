import 'package:json_annotation/json_annotation.dart';

part 'changePassword.g.dart';

@JsonSerializable()
class UpdatePassword {
  UpdatePassword({
    required this.current,
    required this.updatePasswordNew,
  });

  final String? current;
  final String? updatePasswordNew;

  factory UpdatePassword.fromJson(Map<String, dynamic> json) =>
      _$UpdatePasswordFromJson(json);

  Map<String, dynamic> toJson() => _$UpdatePasswordToJson(this);
}
