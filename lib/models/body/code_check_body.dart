import 'package:json_annotation/json_annotation.dart';

part "code_check_body.g.dart";

@JsonSerializable(fieldRename: FieldRename.snake)
class CodeCheckBody {
  final String phone;
  final String code;

  CodeCheckBody({
    required this.phone,
    required this.code,
  });

  factory CodeCheckBody.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$CodeCheckBodyFromJson(json);

  Map<String, dynamic> toJson() => _$CodeCheckBodyToJson(this);
}
