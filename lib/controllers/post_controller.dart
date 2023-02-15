import 'package:gdsc_mobile_project/controllers/auth_controller.dart';
import 'package:gdsc_mobile_project/models/post_model.dart';
import 'package:gdsc_mobile_project/services/post_service.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  AuthController authCtrl = Get.find<AuthController>();
  final PostService postService = PostService();
  //List<post>
  Post? post;

  Future<bool> writePost(
      {required String title, required String description}) async {
    try {
      final Post? result = await postService.writePost(
          title: title,
          description: description,
          id: authCtrl.currentUser.value!.id);
      post = result!;
      return true;
    } catch (e) {
      return false;
    }
  }

  Post? getPost() {
    return post;
  }

  //Future<List<PostMo>> getPosts
}
