import 'package:gdsc_mobile_project/models/user_model.dart';
import 'package:gdsc_mobile_project/services/auth_service.dart';
import 'package:gdsc_mobile_project/services/user_service.dart';
import 'package:gdsc_mobile_project/utils/token_manager.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AuthController extends GetxController with TokenManager {
  final authService = AuthService();
  final userService = UserService();

  Rxn<UserModel> user = Rxn<UserModel>();

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

  Future<bool> signUp(String phone, String code) async {
    final result = await authService.signUp(phone, code);
    print('signUp 결과');
    print(result);

    if (result) {
      user.value = await userService.getUser();
      return true;
    } else {
      return false;
    }
  }
}
