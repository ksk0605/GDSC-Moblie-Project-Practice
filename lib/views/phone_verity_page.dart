import 'package:flutter/material.dart';
import 'package:gdsc_mobile_project/controllers/auth_controller.dart';
import 'package:gdsc_mobile_project/views/code_input_page.dart';
import 'package:get/get.dart';

class PhoneNumberVerificationPage extends StatefulWidget {
  const PhoneNumberVerificationPage({Key? key}) : super(key: key);

  @override
  State<PhoneNumberVerificationPage> createState() =>
      _PhoneNumberVerificationPageState();
}

class _PhoneNumberVerificationPageState
    extends State<PhoneNumberVerificationPage> {
  final TextEditingController _inputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "전화번호 인증",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Form(
            key: _formKey,
            child: TextFormField(
              keyboardType: TextInputType.phone,
              controller: _inputController,
              decoration: InputDecoration(
                hintText: "전화번호를 입력하세요",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
              validator: (value) {
                final phoneNumRegex = RegExp(r'^010-?([0-9]{4})-?([0-9]{4})$');
                // 전화번호 유효성 검사
                if (value == null || value.isEmpty) {
                  return '입력창이 비어있습니다.';
                } else if (!phoneNumRegex.hasMatch(value)) {
                  return "유효한 전화번호가 아닙니다.";
                } else {
                  return null;
                }
              },
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              child: Text("인증번호 받기", style: TextStyle(fontSize: 21)),
              onPressed: () async {
                // 입력한 전화번호가 유효할 시 코드입력페이지로 이동
                if (_formKey.currentState!.validate()) {
                  final isOk =
                      await _authController.getCode(_inputController.text);
                  print(isOk);
                  if (isOk) {
                    Get.off(() => CodeInputPage(phone: _inputController.text));
                  }
                }
              },
            ),
          ),
        ]),
      ),
    );
  }
}
