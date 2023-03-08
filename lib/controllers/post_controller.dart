import 'package:gdsc_mobile_project/controllers/auth_controller.dart';
import 'package:gdsc_mobile_project/models/post_model.dart';
import 'package:gdsc_mobile_project/services/post_service.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  AuthController authCtrl = Get.find<AuthController>();
  final PostService postService = PostService();
  RxList<Post?> posts = <Post?>[].obs;
  Post? post;

  @override
  void onInit() {
    getPost();
    super.onInit();
  }

  Future<bool> writePost(
      {required String title, required String description}) async {
    try {
      print(authCtrl.currentUser);
      final Post? result = await postService.writePost(
          title: title,
          description: description,
          id: authCtrl.currentUser.value!.id);
      post = result!;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  getPost() async {
    final result = await postService.getPosts();
    if (result != null) {
      posts.value = result;
    }
  }

  //Future<List<PostMo>> getPosts
}
