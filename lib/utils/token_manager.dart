import 'package:get_storage/get_storage.dart';
import '../data.dart';

mixin TokenManager {
  final box = GetStorage();

  String readToken(String key) {
    return box.read(key);
  }

  void writeToken(
      {required String access_token, required String refresh_token}) {
    print(access_token);
    print(refresh_token);
    box.write(ACCESS_TOKEN_KEY, access_token);
    box.write(REFRESH_TOKEN_KEY, refresh_token);
  }

  void removeToken() {
    box.remove(ACCESS_TOKEN_KEY);
    box.remove(REFRESH_TOKEN_KEY);
  }
}
