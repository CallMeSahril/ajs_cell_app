import 'package:ajs_cell_app/app/domain/auth/repositories/auth_repositories.dart';
import 'package:ajs_cell_app/app/domain/auth/usescases/post_login.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostLogin>(
      () => PostLogin(Get.find<AuthRepositories>()),
    );

    Get.lazyPut<LoginController>(
      () => LoginController(postLogin: Get.find<PostLogin>()),
    );
  }
}
