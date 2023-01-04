import 'package:dio/dio.dart';
import 'package:gdsc_mobile_project/models/auth_body.dart';
import 'package:gdsc_mobile_project/models/code_check_body.dart';

import '../data.dart';

class AuthService {
  String url = baseUrl + 'api/v1/authorizations';
  String? code;
  String? message;

  Future<bool> getCode(String phoneNum) async {
    try {
      final res = await Dio().post(
        url,
        data: {"auth": AuthBody(phone: phoneNum).toJson()},
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

  Future<bool> checkCode(String phone, String code) async {
    try {
      print('asf');
      final res = await Dio().get(url, queryParameters: {
        "auth": CodeCheckBody(code: code, phone: phone).toJson()
      });
      if (res.data['status'] == 'ok') {
        print(res.data);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> checkSignedUp(String phone) async {
    try {
      final res = await Dio().post(url + '/check_signed_up',
          data: {'auth': AuthBody(phone: phone).toJson()});
      if (res.data['status'] == 'ok') {
        return res.data['terms_accepted_at'] == null ? false : true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  void refreshCode() {}
}
