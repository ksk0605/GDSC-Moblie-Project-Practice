import 'package:json_annotation/json_annotation.dart';
part 'sign_up_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SignUpResponse {
  final String accessToken;
  final String refreshToken;

  SignUpResponse({
    required this.accessToken,
    required this.refreshToken,
  });

  factory SignUpResponse.fromJson(Map<String, dynamic> json) =>
      _$SignUpResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpResponseToJson(this);
}
