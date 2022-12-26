import 'package:dio/dio.dart';
import 'package:gdsc_mobile_project/baseURL.dart';
import 'package:gdsc_mobile_project/models/auth_model.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AuthController extends GetxController {
  String? code;
  String? message;

  Future<bool> getCode(String phoneNum) async {
    try {
      final res = await Dio().post(
        baseUrl + 'api/v1/authorizations',
        data: {"auth": AuthModel(phone: phoneNum).toJson()},
      );
      print(res);
      code = res.data['result']['code'];
      message = res.data['result']['text'];
      print(code);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  void refreshCode() {}
}
