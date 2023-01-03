import 'package:flutter/material.dart';
import 'package:gdsc_mobile_project/views/home_page.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class CodeInputPage extends StatelessWidget {
  CodeInputPage({super.key});
  final TextEditingController _inputController = TextEditingController();
  final _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "코드 입력",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          TextField(
            keyboardType: TextInputType.phone,
            controller: _inputController,
            decoration: InputDecoration(
              hintText: "인증번호 입력",
              // 테두리
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              child: Text("완료", style: TextStyle(fontSize: 21)),
              onPressed: () {
                // HomePage로 이동
                if (_authController.code! == _inputController.text) {
                  Get.off(HomePage());
                } else {}
              },
            ),
          ),
        ]),
      ),
    );
  }
}
