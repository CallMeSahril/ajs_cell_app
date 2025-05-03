import 'package:ajs_cell_app/app/core/config/token.dart';
import 'package:ajs_cell_app/app/core/errors/failure.dart';
import 'package:ajs_cell_app/app/domain/auth/entities/register_request.dart';
import 'package:ajs_cell_app/app/domain/auth/usescases/post_login.dart';
import 'package:ajs_cell_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController
  final PostLogin _postLogin;

  LoginController({required PostLogin postLogin}) : _postLogin = postLogin;

  // Text Editing Controllers
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final addressController = TextEditingController();

  // State
  final isLoading = false.obs;

  Future<Map<String, dynamic>> login() async {
    if (!_validateInputs()) {
      return {
        "isSuccess": false,
        "message": "Mohon lengkapi semua field.",
      };
    }

    isLoading.value = true;
    final storage = await AuthStorage.getInstance();

    final result = await _postLogin(RegisterRequest(
      email: emailController.text,
      password: passwordController.text,
    ));

    isLoading.value = false;

    return result.fold(
      (failure) {
        String message = switch (failure) {
          NoConnectionFailure() => 'Tidak ada koneksi internet',
          SlowConnectionFailure() => 'Koneksi internet lambat',
          _ => failure.message ?? 'Terjadi kesalahan saat mengambil data',
        };
        Get.snackbar(
          "Login Gagal",
          "Email Tidak Terdaftar",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return {
          "isSuccess": false,
          "message": message,
        };
      },
      (data) async {
        // print(data.accessToken);
        await storage.saveToken("${data.tokenType} ${data.accessToken}" ?? '');

        Get.snackbar(
          "Login Berhasil",
          "",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAllNamed(Routes.LOADING);
        return {
          "isSuccess": true,
        };
      },
    );
  }

  bool _validateInputs() {
    return emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    addressController.dispose();
    super.onClose();
  }
}
