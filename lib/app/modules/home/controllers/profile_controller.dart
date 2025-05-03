import 'package:ajs_cell_app/app/core/errors/failure.dart';
import 'package:ajs_cell_app/app/domain/auth/entities/user_entitites.dart';
import 'package:ajs_cell_app/app/domain/auth/usescases/get_profile.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  //TODO: Implement LoginController
  final GetProfile _getProfile;

  ProfileController({required GetProfile getProfile})
      : _getProfile = getProfile;

  var isLoading = false.obs;
  var userData = UserEntity().obs;
  Future<void> getProfile() async {
    isLoading.value = true;

    final result = await _getProfile();

    isLoading.value = false;

    return result.fold(
      (failure) {
        String message = switch (failure) {
          NoConnectionFailure() => 'Tidak ada koneksi internet',
          SlowConnectionFailure() => 'Koneksi internet lambat',
          _ => failure.message ?? 'Terjadi kesalahan saat mengambil data',
        };
        print(message);
      },
      (data) async {
        userData.value = data;
        print(userData.value);
      },
    );
  }

}
