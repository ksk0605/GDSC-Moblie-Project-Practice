// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_body_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostBodyModel _$PostBodyModelFromJson(Map<String, dynamic> json) =>
    PostBodyModel(
      id: json['user_id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$PostBodyModelToJson(PostBodyModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'user_id': instance.id,
    };
