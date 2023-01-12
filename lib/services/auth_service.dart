import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gdsc_mobile_project/models/body/auth_body.dart';
import 'package:gdsc_mobile_project/models/body/code_check_body.dart';
import 'package:gdsc_mobile_project/models/body/sign_up_body.dart';
import 'package:gdsc_mobile_project/models/response/login_response.dart';
import 'package:gdsc_mobile_project/models/response/sign_up_response.dart';
import 'package:gdsc_mobile_project/utils/token_manager.dart';

import '../data.dart';

class AuthService with TokenManager {
  String url = baseUrl + 'api/v1/authorizations';

  Future<bool> getCode(String phoneNum) async {
    try {
      final res = await Dio().post(
        url,
        data: {"auth": AuthBody(phone: phoneNum).toJson()},
      );
      print(res);
      return true;
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
      print(res.data);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> checkSignedUp(String phone) async {
    try {
      final res = await Dio().post(url + '/check_signed_up',
          data: {'auth': AuthBody(phone: phone).toJson()});
      print(res.data);
      return res.data['terms_accepted_at'] == null ? false : true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> signUp(String phone, String code) async {
    String credentials = "$phone: $code";
    Codec<String, String> stringToBase64Url = utf8.fuse(base64Url);
    String encoded = stringToBase64Url.encode(credentials);

    print(DateTime.now().toString());

    try {
      final res = await Dio().post(url + '/sign_up',
          options: Options(headers: {"Authorization": "Basic $encoded"}),
          data: {
            "auth": SignUpBody(terms_accepted_at: DateTime.now()).toJson()
          });

      print('유저가입하기');
      print(res);

      final tokens = SignUpResponse.fromJson(res.data["token"]);
      writeToken(ACCESS_TOKEN_KEY, tokens.accessToken);
      writeToken(REFRESH_TOKEN_KEY, tokens.refreshToken);

      return true;
    } catch (e) {
      print('에러');
      return false;
    }
  }

  Future<bool> login(String phone, String code) async {
    String credentials = "$phone: $code";
    Codec<String, String> stringToBase64Url = utf8.fuse(base64Url);
    String encoded = stringToBase64Url.encode(credentials);

    try {
      final res = await Dio().post(
        url + '/login',
        options: Options(headers: {"Authorization": "Basic $encoded"}),
      );
      print('로그인 결과');
      print(res);
      final tokens = LoginResponse.fromJson(res.data);

      writeToken(ACCESS_TOKEN_KEY, tokens.accessToken);
      writeToken(REFRESH_TOKEN_KEY, tokens.refreshToken);
      return true;
    } catch (e) {
      return false;
    }
  }
}
