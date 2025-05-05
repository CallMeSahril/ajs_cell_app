import 'package:ajs_cell_app/app/domain/products/repositories/products_repositories.dart';
import 'package:ajs_cell_app/app/domain/products/usescases/get_category_product_all.dart';
import 'package:ajs_cell_app/app/modules/home/controllers/kategori_controller.dart';
import 'package:get/get.dart';

class KategoriBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetCategoryProductAll>(
      () => GetCategoryProductAll(Get.find<ProductsRepositories>()),
    );

    Get.lazyPut<KategoriController>(
      () => KategoriController(
        getCategoryProductAll: Get.find<GetCategoryProductAll>(),
      ),
    );
  }
}
