import 'package:gdsc_mobile_project/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AuthController extends GetxController {
  final authService = AuthService();

  Future<bool> getCode(String phoneNum) async {
    final result = await authService.getCode(phoneNum);
    return result;
  }

  Future<bool> checkCode(String phone, String code) async {
    final result = await authService.checkCode(phone, code);
    return result;
  }

  Future<bool> checkSignedUp(String phone) async {
    final result = await authService.checkSignedUp(phone);
    return result;
  }

  void refreshCode() {}
}
