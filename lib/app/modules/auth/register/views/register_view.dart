import 'package:ajs_cell_app/app/widgets/button/custom_button.dart';
import 'package:ajs_cell_app/app/widgets/textfield/custom_text_form_field.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
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
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Silahkan daftar terlebih dahulu',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff0245A3)),
                ),
                Text(
                  'Silahkan lengkapi data dibawah untuk menggunakan aplikasi.',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Column(
              spacing: 10,
              children: [
                CustomTextFormField(
                  title: 'Nama Lengkap',
                  controller: controller.nameController,
                ),
                CustomTextFormField(
                  title: 'Nama Telepon',
                  controller: controller.phoneController,
                ),
                CustomTextFormField(
                  title: 'Email',
                  controller: controller.emailController,
                ),
                CustomTextFormField(
                  title: 'Password',
                  controller: controller.passwordController,
                ),
                CustomTextFormField(
                  title: 'Alamat',
                  controller: controller.addressController,
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xffFFFFFF),
        child: CustomButton(
          type: ButtonType.blue,
          text: "DAFTAR",
          onTap: () {
            controller.register();
          },
        ),
      ),
    );
  }
}
