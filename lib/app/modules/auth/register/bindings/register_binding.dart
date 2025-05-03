import 'package:ajs_cell_app/app/domain/auth/repositories/auth_repositories.dart';
import 'package:ajs_cell_app/app/domain/auth/usescases/post_login.dart';
import 'package:get/get.dart';

import '../../../../domain/auth/usescases/post_register.dart';
import '../controllers/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostRegister>(
      () => PostRegister(Get.find<AuthRepositories>()),
    );
 
    Get.lazyPut<RegisterController>(
      () => RegisterController(postRegister: Get.find<PostRegister>()),
    );
  }
}
