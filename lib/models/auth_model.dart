import 'package:json_annotation/json_annotation.dart';

part 'auth_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AuthModel {
  final String phone;

  AuthModel({required this.phone});

  factory AuthModel.fromJson(Map<String, dynamic> json) =>
      _$AuthModelFromJson(json);
  Map<String, dynamic> toJson() => _$AuthModelToJson(this);
}
