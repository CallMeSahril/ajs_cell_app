import 'package:ajs_cell_app/app/domain/products/repositories/products_repositories.dart';
import 'package:ajs_cell_app/app/domain/products/usescases/get_category_product_by_id.dart';
import 'package:get/get.dart';

import '../controllers/detail_katagori_controller.dart';

class DetailKatagoriBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetCategoryProductById>(
      () => GetCategoryProductById(Get.find<ProductsRepositories>()),
    );
    Get.lazyPut<DetailKatagoriController>(
      () => DetailKatagoriController(
          id: Get.arguments['id'],
          title: Get.arguments['title'],
          getCategoryProductById: Get.find<GetCategoryProductById>()),
    );
  }
}
