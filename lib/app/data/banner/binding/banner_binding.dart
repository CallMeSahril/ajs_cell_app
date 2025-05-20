import 'package:ajs_cell_app/app/data/banner/controller/banner_controller.dart';
import 'package:get/get.dart';

class BannerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BannerController>(() => BannerController());
  }
}
