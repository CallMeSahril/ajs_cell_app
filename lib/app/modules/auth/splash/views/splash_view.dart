import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends StatelessWidget {
  final SplashController controller = Get.find<SplashController>();
  SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0245A3),
      body: Center(
        child: Image.asset('assets/logo/logo.png'),
      ),
    );
  }
}
