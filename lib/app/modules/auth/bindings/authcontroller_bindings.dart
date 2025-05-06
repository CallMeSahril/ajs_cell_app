import 'package:ajs_cell_app/app/modules/auth/controller/auth_controller.dart';
import 'package:get/get.dart';

class AuthcontrollerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
