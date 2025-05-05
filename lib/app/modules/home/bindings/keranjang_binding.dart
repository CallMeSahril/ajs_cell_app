import 'package:ajs_cell_app/app/domain/carts/repositories/repositories.dart';
import 'package:ajs_cell_app/app/domain/carts/usescases/get_cart.dart';
import 'package:ajs_cell_app/app/modules/home/controllers/keranjang_controller.dart';
import 'package:get/get.dart';

class KeranjangBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetCart>(
      () => GetCart(Get.find<CartsRepositories>()),
    );

    Get.lazyPut<KeranjangController>(
      () => KeranjangController(
        getCart: Get.find<GetCart>(),
      ),
    );
  }
}
