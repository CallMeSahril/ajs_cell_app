import 'package:ajs_cell_app/app/data/banner/controller/banner_controller.dart';
import 'package:ajs_cell_app/app/domain/carts/repositories/repositories.dart';
import 'package:ajs_cell_app/app/domain/carts/usescases/post_cart.dart';
import 'package:ajs_cell_app/app/domain/products/repositories/products_repositories.dart';
import 'package:ajs_cell_app/app/domain/products/usescases/get_product_all.dart';
import 'package:ajs_cell_app/app/domain/products/usescases/get_product_by_id.dart';
import 'package:ajs_cell_app/app/modules/home/controllers/beranda_controller.dart';
import 'package:get/get.dart';

class BerandaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetAllProducts>(
      () => GetAllProducts(Get.find<ProductsRepositories>()),
    );
    Get.lazyPut<GetProductById>(
      () => GetProductById(Get.find<ProductsRepositories>()),
    );
    Get.lazyPut<PostCart>(
      () => PostCart(Get.find<CartsRepositories>()),
    );
     
    Get.lazyPut<BerandaController>(
      () => BerandaController(
        getAllProducts: Get.find<GetAllProducts>(),
        getProductIByid: Get.find<GetProductById>(),
        postCart: Get.find<PostCart>(),
      ),
    );
  }
}
