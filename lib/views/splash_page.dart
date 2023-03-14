import 'package:flutter/material.dart';
import 'package:gdsc_mobile_project/controllers/auth_controller.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _authController = Get.put(AuthController());

  @override
  void initState() {
    _authController.checkTokenState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
        "Splash Page",
        style: TextStyle(fontWeight: FontWeight.bold),
      )),
    );
  }
}
