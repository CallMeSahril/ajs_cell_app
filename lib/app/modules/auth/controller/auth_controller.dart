import 'dart:io';
import 'package:ajs_cell_app/app/domain/auth/usescases/update_profile_usescase.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final UpdateProfileUsecase _updateProfileUsecase = UpdateProfileUsecase();

  Future<bool> updateProfile({
    required String name,
    required String email,
    required String phone,
    File? image,
  }) async {
    final result = await _updateProfileUsecase(
      name: name,
      email: email,
      phone: phone,
      image: image,
    );

    return result.fold(
      (failure) {
        Get.snackbar("Gagal", failure.message ?? "Terjadi kesalahan");
        return false;
      },
      (success) {
        Get.snackbar("Sukses", "Profil berhasil diperbarui");
        return true;
      },
    );
  }
}
