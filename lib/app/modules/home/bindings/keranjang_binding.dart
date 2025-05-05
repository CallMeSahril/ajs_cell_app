import 'package:ajs_cell_app/app/domain/carts/repositories/repositories.dart';
import 'package:ajs_cell_app/app/domain/carts/usescases/delete_cart.dart';
import 'package:ajs_cell_app/app/domain/carts/usescases/get_cart.dart';
import 'package:ajs_cell_app/app/domain/carts/usescases/post_cart.dart';
import 'package:ajs_cell_app/app/domain/carts/usescases/update_quantity.dart';
import 'package:ajs_cell_app/app/modules/home/controllers/keranjang_controller.dart';
import 'package:get/get.dart';

class KeranjangBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetCart>(
      () => GetCart(Get.find<CartsRepositories>()),
    );
    Get.lazyPut<DeleteCart>(
      () => DeleteCart(Get.find<CartsRepositories>()),
    );
    Get.lazyPut<PostCart>(
      () => PostCart(Get.find<CartsRepositories>()),
    );
    Get.lazyPut<UpdateQuantity>(
      () => UpdateQuantity(Get.find<CartsRepositories>()),
    );
    Get.lazyPut<KeranjangController>(
      () => KeranjangController(
        getCart: Get.find<GetCart>(),
        deleteCart: Get.find<DeleteCart>(),
        postCart: Get.find<PostCart>(),
        updateQuantity: Get.find<UpdateQuantity>(),
      ),
    );
  }
}
