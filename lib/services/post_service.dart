import 'package:dio/dio.dart';
import 'package:gdsc_mobile_project/data.dart';
import 'package:gdsc_mobile_project/models/body/post_body_model.dart';
import 'package:gdsc_mobile_project/models/post_model.dart';
import 'package:gdsc_mobile_project/utils/token_manager.dart';

class PostService with TokenManager {
  final url = '$baseUrl/api/v1/posts';

  Future<Post?> writePost(
      {required String title,
      required String description,
      required int id}) async {
    try {
      print('asd');
      final token = readToken(ACCESS_TOKEN_KEY);
      print(token);
      final res = await Dio().post(url,
          options: Options(headers: {"Authorization": "Bearer $token"}),
          data: {
            'post':
                PostBodyModel(description: description, title: title, id: id)
          });
      print(res.data['post']['description']);
      final post = Post.fromJson(res.data['post']);
      print(post);
      return post;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Post>?> getPosts() async {
    try {
      final res = await Dio().get(url,
          options: Options(headers: {
            'Authorization': 'Bearer ${readToken(ACCESS_TOKEN_KEY)}'
          }));
      print(res.data);
      final posts = Post.fromJsonList(res.data['posts']);
      return posts;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
