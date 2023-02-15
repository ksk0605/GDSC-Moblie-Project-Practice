import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gdsc_mobile_project/controllers/auth_controller.dart';
import 'package:gdsc_mobile_project/controllers/post_controller.dart';
import 'package:gdsc_mobile_project/models/post_model.dart';
import 'package:gdsc_mobile_project/utils/app_style.dart';
import 'package:gdsc_mobile_project/widgets/post_card.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final authController = Get.put(AuthController());

  final titleController = TextEditingController();

  final descriptionContorller = TextEditingController();

  final postController = Get.put(PostController());

  Post? post;

  @override
  void initState() {
    // TODO: implement initState
    post = postController.getPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '오늘의 기분',
          style: Styles.titleText,
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: post == null
          ? Center(
              child: Text('나의 기분을 작성해주세요!'),
            )
          : Padding(
              padding: const EdgeInsets.all(24.0),
              child: Center(
                child: PostCard(
                  title: post!.title,
                  description: post!.description,
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog<String>(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) => _PostDialog(
                titleController: titleController,
                descriptionController: descriptionContorller,
                postCtrl: postController,
                onPressed: () async {
                  final result = await postController.writePost(
                      title: titleController.text,
                      description: descriptionContorller.text);
                  setState(() {
                    post = postController.getPost();
                  });
                  titleController.clear();
                  descriptionContorller.clear();
                  Get.back();
                  if (result) {
                    Get.snackbar('글쓰기', '글쓰기 성공',
                        snackPosition: SnackPosition.TOP);
                  } else {
                    Get.snackbar('글쓰기', '글쓰기 실패',
                        snackPosition: SnackPosition.TOP);
                  }
                })),
        child: Icon(CupertinoIcons.plus),
      ),
    );
  }

  getPost() {
    postController.getPost();
  }
}

class _PostDialog extends StatelessWidget {
  final titleController;
  final descriptionController;
  final postCtrl;
  final onPressed;
  _PostDialog({
    Key? key,
    required this.titleController,
    required this.descriptionController,
    required this.postCtrl,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '오늘은 어떠셨나요?',
              style: Styles.titleText,
            ),
            Gap(20),
            TextFormField(
              controller: titleController,
              keyboardType: TextInputType.multiline,
              maxLines: 1,
              minLines: 1,
              decoration: new InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  //focusColor: Colors.grey[600],
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none, //검색 아이콘 추가
                  hintText: '제목을 입력하세요'),
            ),
            Gap(10),
            TextFormField(
              controller: descriptionController,
              keyboardType: TextInputType.multiline,
              maxLines: 10,
              minLines: 10,
              decoration: new InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  //focusColor: Colors.grey[600],
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none, //검색 아이콘 추가
                  hintText: '내용을 입력하세요'),
            ),
            const SizedBox(height: 15),
            Container(
                width: double.infinity,
                child: ElevatedButton(
                    child: Text(
                      '글쓰기',
                      style: Styles.descriptionText,
                    ),
                    onPressed: onPressed)),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Close',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
