import 'package:json_annotation/json_annotation.dart';

part 'auth_body.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AuthBody {
  final String phone;

  AuthBody({required this.phone});

  factory AuthBody.fromJson(Map<String, dynamic> json) =>
      _$AuthBodyFromJson(json);
  Map<String, dynamic> toJson() => _$AuthBodyToJson(this);
}
