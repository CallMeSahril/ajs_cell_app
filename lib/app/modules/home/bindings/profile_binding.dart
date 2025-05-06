import 'package:ajs_cell_app/app/domain/auth/repositories/auth_repositories.dart';
import 'package:ajs_cell_app/app/domain/auth/usescases/get_profile.dart';
import 'package:ajs_cell_app/app/modules/auth/controller/auth_controller.dart';
import 'package:ajs_cell_app/app/modules/home/controllers/profile_controller.dart';
import 'package:get/get.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetProfile>(
      () => GetProfile(Get.find<AuthRepositories>()),
    );
    Get.lazyPut<AuthController>( () => AuthController());
    Get.lazyPut<ProfileController>(
      () => ProfileController(
        getProfile: Get.find<GetProfile>(),
      ),
    );
  }
}
