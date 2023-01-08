import 'package:dio/dio.dart';
import 'package:gdsc_mobile_project/models/user_model.dart';
import 'package:gdsc_mobile_project/utils/token_manager.dart';

import '../data.dart';

class UserService with TokenManager {
  String url = baseUrl + 'api/v1/users/';

  Future<UserModel?> getUser() async {
    String access_key = readToken(ACCESS_TOKEN_KEY);
    try {
      final res = await Dio().get(url,
          options: Options(headers: {"Authorization": "Bearer " + access_key}));
      print('유저정보 가져오기');
      print(res);
      if (res.data['status'] == 'ok') {
        final user = UserModel(
            id: res.data['user']['id'],
            phone: res.data['user']['phone'],
            username: res.data['user']['username']);
        return user;
      }
    } catch (e) {
      return null;
    }
  }
}
