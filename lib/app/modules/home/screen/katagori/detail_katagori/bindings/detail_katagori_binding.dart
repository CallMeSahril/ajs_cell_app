import 'package:get/get.dart';

import '../controllers/detail_katagori_controller.dart';

class DetailKatagoriBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailKatagoriController>(
      () => DetailKatagoriController(title: Get.arguments['title']),
    );
  }
}
