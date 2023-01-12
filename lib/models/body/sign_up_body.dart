import 'package:json_annotation/json_annotation.dart';

part 'sign_up_body.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SignUpBody {
  final DateTime terms_accepted_at;

  SignUpBody({required this.terms_accepted_at});

  factory SignUpBody.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$SignUpBodyFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpBodyToJson(this);
}
