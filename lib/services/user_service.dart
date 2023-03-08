import 'package:dio/dio.dart';
import 'package:gdsc_mobile_project/models/response/get_user_response.dart';
import 'package:gdsc_mobile_project/models/user_model.dart';
import 'package:gdsc_mobile_project/utils/token_manager.dart';

import '../data.dart';

class UserService with TokenManager {
  String url = baseUrl + 'api/v1/users/';

  Future<UserModel?> getUser() async {
    String? access_key = readToken(ACCESS_TOKEN_KEY);
    print(access_key);
    try {
      print(url);
      final res = await Dio().get(url,
          options: Options(headers: {
            "Authorization": "Bearer ${readToken(ACCESS_TOKEN_KEY)}"
          }));
      print('유저정보 가져오기');
      print(res);

      final userData = GetUserResponse.fromJson(res.data);

      final user = userData.user;
      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
