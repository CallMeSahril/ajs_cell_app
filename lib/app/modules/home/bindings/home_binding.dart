import 'package:ajs_cell_app/app/modules/home/controllers/riwayat_controller.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<RiwayatController>(
      () => RiwayatController(),
    );
  }
}
