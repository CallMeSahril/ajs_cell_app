import 'package:ajs_cell_app/app/core/config/token.dart';
import 'package:ajs_cell_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _checkToken();
  }

  Future<void> _checkToken () async {
    await Future.delayed(const Duration(seconds: 3));
    final hasToken = await getToken();
    if (hasToken) {
      Get.offAllNamed(Routes.LOADING);
    } else {
      Get.offAllNamed(Routes.LOGIN);
    }
  }

  Future<bool> getToken() async {
    final token = await AuthHelper.getToken();
    return token != null;
  }
}
