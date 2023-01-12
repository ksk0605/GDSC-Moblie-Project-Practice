import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gdsc_mobile_project/views/home_page.dart';
import 'package:gdsc_mobile_project/views/sign_up_page.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class CodeInputPage extends StatefulWidget {
  const CodeInputPage({super.key, required this.phone});
  final String phone;

  @override
  State<CodeInputPage> createState() => _CodeInputPageState();
}

class _CodeInputPageState extends State<CodeInputPage> {
  final TextEditingController _inputController = TextEditingController();

  final _authController = Get.put(AuthController());
  bool _isChecked = false;

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
              onPressed: () async {
                // HomePage로 이동
                if (_inputController.text.isNotEmpty) {
                  final verify = await _authController.checkCode(
                      widget.phone, _inputController.text);
                  if (verify) {
                    final isSigned =
                        await _authController.checkSignedUp(widget.phone);
                    if (isSigned) {
                      print('가입된 계정');
                      Get.off(HomePage());
                    } else {
                      //openBottomSheet();
                      //Get.off(() => SignUpPage());
                      print('가입 안된 계정');
                      await _showBottomSheet(context);
                    }
                  }
                } else {}
              },
            ),
          ),
        ]),
      ),
    );
  }

  Future<void> _showBottomSheet(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (BuildContext context,
            StateSetter setState /*You can rename this!*/) {
          return SizedBox(
            height: 500,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 25),
                    Text(
                      '서비스 동의',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Divider(
                      thickness: 1.0,
                    ),
                    Row(
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          value: _isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              _isChecked = value!;
                            });
                          },
                        ),
                        Text('[필수] 이용약관')
                      ],
                    ),
                    SizedBox(
                      height: 180,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        child: Text("동의하고 가입하기",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400)),
                        onPressed: () async {
                          if (_isChecked == true) {
                            final result = await _authController.signUp(
                                widget.phone, _inputController.text);
                            if (result) {
                              Get.offAll(HomePage());
                            }
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
