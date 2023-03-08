import 'package:get_storage/get_storage.dart';
import '../data.dart';

mixin TokenManager {
  final box = GetStorage();

  String? readToken(String tokenKey) {
    return box.read(tokenKey);
  }

  Future<void> writeToken(String tokenKey, String token) async {
    await box.write(tokenKey, token);
  }

  Future<void> removeToken(String tokenKey) async {
    await box.remove(tokenKey);
  }
}
