import 'package:ajs_cell_app/app/data/banner/controller/banner_controller.dart';
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
    Get.lazyPut<BannerController>(
      () => BannerController(),
    );
  }
}
