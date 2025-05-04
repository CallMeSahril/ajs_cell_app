import 'package:ajs_cell_app/app/domain/products/repositories/products_repositories.dart';
import 'package:ajs_cell_app/app/domain/products/usescases/get_product_all.dart';
import 'package:ajs_cell_app/app/modules/home/controllers/beranda_controller.dart';
import 'package:get/get.dart';

class BerandaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetAllProducts>(
      () => GetAllProducts(Get.find<ProductsRepositories>()),
    );
    Get.lazyPut<BerandaController>(
      () => BerandaController(
        getAllProducts: Get.find<GetAllProducts>(),
      ),
    );
  }
}
