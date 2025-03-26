import 'package:ajs_cell_app/app/routes/app_pages.dart';
import 'package:ajs_cell_app/app/widgets/button/custom_button.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/welcome_controller.dart';

class WelcomeView extends GetView<WelcomeController> {
  const WelcomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      appBar: AppBar(
        backgroundColor: Color(0xffFFFFFF),
        title: const Text(''),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              spacing: 10,
              children: [
                Image.asset(
                  'assets/logo/logo.png',
                  width: 100,
                ),
                Text(
                  'Selamat Datang di AJS Cell ',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff0245A3)),
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  'Silakan login atau daftarkan diri Anda sebelum menggunakan aplikasi ini.',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Column(
              spacing: 10,
              children: [
                CustomButton(
                  type: ButtonType.grey,
                  text: "DAFTAR",
                  onTap: () => Get.toNamed(Routes.REGISTER),
                ),
                CustomButton(
                  type: ButtonType.blue,
                  text: "LOGIN",
                  onTap: () => Get.toNamed(Routes.LOGIN),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
