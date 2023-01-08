import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gdsc_mobile_project/models/body/auth_body.dart';
import 'package:gdsc_mobile_project/models/body/code_check_body.dart';
import 'package:gdsc_mobile_project/models/body/sign_up_body.dart';
import 'package:gdsc_mobile_project/utils/token_manager.dart';

import '../data.dart';

class AuthService with TokenManager {
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
      if (res.data['status'] == 'ok') {
        // code = res.data['result']['code'];
        // message = res.data['result']['text'];
        //print(code);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> checkCode(String phone, String code) async {
    try {
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
        print(res.data);
        return res.data['terms_accepted_at'] == null ? false : true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> signUp(String phone, String code) async {
    String credentials = "$phone: $code";
    Codec<String, String> stringToBase64Url = utf8.fuse(base64Url);
    String encoded = stringToBase64Url.encode(credentials);

    try {
      final res = await Dio().post(url + '/sign_up',
          options: Options(headers: {"Authorization": "Basic " + encoded}),
          data: {"auth": SignUpBody(data: DateTime.now().toString()).toJson()});
      print('유저가입하기');
      print(res);
      if (res.data['status'] == 'ok') {
        String access_token = res.data['token']['access_token'];
        String refresh_token = res.data['token']['refresh_token'];

        writeToken(access_token: access_token, refresh_token: refresh_token);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('에러');
      return false;
    }
  }
}
