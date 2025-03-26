import 'package:ajs_cell_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed(Routes.WELCOME);
    });
    return Scaffold(
      backgroundColor: Color(0xff0245A3),
      body: Center(
        child: Image.asset('assets/logo/logo.png'),
      ),
    );
  }
}
