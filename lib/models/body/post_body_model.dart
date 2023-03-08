import 'package:json_annotation/json_annotation.dart';
part 'post_body_model.g.dart';

// flutter pub run build_runner build
@JsonSerializable(fieldRename: FieldRename.snake)
class PostBodyModel {
  final String title;
  final String description;
  @JsonKey(name: "user_id")
  final int id;

  PostBodyModel({
    required this.id,
    required this.title,
    required this.description,
  });
  factory PostBodyModel.fromJson(Map<String, dynamic> json) =>
      _$PostBodyModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostBodyModelToJson(this);
}
