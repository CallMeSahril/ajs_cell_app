import 'package:ajs_cell_app/app/routes/app_pages.dart';
import 'package:ajs_cell_app/app/widgets/button/custom_button.dart';
import 'package:ajs_cell_app/app/widgets/textfield/custom_text_form_field.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/logo/keys_1.png',
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Silahkan login terlebih dahulu',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff0245A3)),
                ),
                Text(
                  'Silahkan masukkan email dan password.',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Column(
                spacing: 20,
                children: [
                  CustomTextFormField(
                    title: 'Email',
                    controller: controller.emailController,
                  ),
                  CustomTextFormField(
                    title: 'Password',
                    controller: controller.passwordController,
                  ),
                ],
              ),
            ),
SizedBox(height: 10,),            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.REGISTER);
              },
              child: Text(
                "Klik di sini untuk daftar",
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xffFFFFFF),
        child: CustomButton(
          type: ButtonType.blue,
          text: "LOGIN",
          // onTap: () => Get.offAllNamed(Routes.LOADING),
          onTap: () => controller.login(),
        ),
      ),
    );
  }
}
