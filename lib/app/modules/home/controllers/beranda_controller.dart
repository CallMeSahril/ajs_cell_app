import 'package:ajs_cell_app/app/core/errors/failure.dart';
import 'package:ajs_cell_app/app/domain/products/entities/product_entities.dart';
import 'package:ajs_cell_app/app/domain/products/usescases/get_product_all.dart';
import 'package:get/get.dart';

class BerandaController extends GetxController {
  final GetAllProducts _getAllProducts;
  BerandaController({required GetAllProducts getAllProducts})
      : _getAllProducts = getAllProducts;

  var isLoading = false.obs;
  var allProducts = <ProductEntities>[].obs;
  Future<void> getAllProducts() async {
    isLoading.value = true;

    final result = await _getAllProducts();

    isLoading.value = false;

    return result.fold(
      (failure) {
        String message = switch (failure) {
          NoConnectionFailure() => 'Tidak ada koneksi internet',
          SlowConnectionFailure() => 'Koneksi internet lambat',
          _ => failure.message ?? 'Terjadi kesalahan saat mengambil data',
        };
        print(message);
      },
      (data) async {
        allProducts.value = data;
        print(allProducts.value);
      },
    );
  }
}
