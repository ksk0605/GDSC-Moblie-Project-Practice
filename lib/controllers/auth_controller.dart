import 'package:gdsc_mobile_project/data.dart';
import 'package:gdsc_mobile_project/models/user_model.dart';
import 'package:gdsc_mobile_project/services/auth_service.dart';
import 'package:gdsc_mobile_project/services/user_service.dart';
import 'package:gdsc_mobile_project/utils/token_manager.dart';
import 'package:gdsc_mobile_project/views/home_page.dart';
import 'package:gdsc_mobile_project/views/phone_verity_page.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AuthController extends GetxController with TokenManager {
  final authService = AuthService();
  final userService = UserService();

  Rxn<UserModel> currentUser = Rxn<UserModel>();

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
      currentUser.value = await userService.getUser();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> login(String phone, String code) async {
    final result = authService.login(phone, code);
    return result;
  }

  Future<void> checkTokenState() async {
    // String? token = readToken(ACCESS_TOKEN_KEY);

    // print(token);

    // if (token != null) {
    //   UserModel? user = await userService.getUser();
    //   currentUser.value = user;
    //   _moveToHome();
    // } else {
    //   _moveToCodeCheck();
    // }
    String? accessToken = readToken(ACCESS_TOKEN_KEY);
    print(accessToken);
    if (accessToken == null || accessToken.isEmpty) {
      _moveToCodeCheck();
      return;
    }
    userService.getUser().then((user) {
      print(user);
      if (user is UserModel) {
        print(user);
        currentUser.value = user;
        _moveToHome();
        return;
      } else {
        _moveToCodeCheck();
        return;
      }
    });
  }

  void _moveToCodeCheck() {
    Future.delayed(const Duration(milliseconds: 2000), () {
      Get.off(() => PhoneNumberVerificationPage());
    });
  }

  void _moveToHome() {
    Future.delayed(const Duration(milliseconds: 2000), () {
      Get.off(() => HomePage());
    });
  }
}
