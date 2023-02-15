import 'package:json_annotation/json_annotation.dart';
part 'post_model.g.dart';

// flutter pub run build_runner build
@JsonSerializable(fieldRename: FieldRename.snake)
class Post {
  final String title;
  final String description;
  final int id;

  Post({
    required this.id,
    required this.title,
    required this.description,
  });
  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}
