import 'package:ajs_cell_app/app/core/errors/failure.dart';
import 'package:ajs_cell_app/app/domain/carts/entities/add_cart_entities.dart';
import 'package:ajs_cell_app/app/domain/carts/usescases/post_cart.dart';
import 'package:ajs_cell_app/app/domain/products/entities/product_entities.dart';
import 'package:ajs_cell_app/app/domain/products/usescases/get_product_all.dart';
import 'package:ajs_cell_app/app/domain/products/usescases/get_product_by_id.dart';
import 'package:get/get.dart';

class BerandaController extends GetxController {
  final GetAllProducts _getAllProducts;
  final GetProductById _getProductById;
  final PostCart _postCart;
  BerandaController({
    required GetAllProducts getAllProducts,
    required GetProductById getProductIByid,
    required PostCart postCart,
  })  : _getAllProducts = getAllProducts,
        _getProductById = getProductIByid,
        _postCart = postCart;

  var isLoading = false.obs;
  var allProducts = <ProductEntities>[].obs;
  var products = ProductEntities().obs;

  Future<bool> postCart({required AddCartEntities post}) async {
    final result = await _postCart(post: post);
    return result.fold(
      (failure) {
        String message = switch (failure) {
          NoConnectionFailure() => 'Tidak ada koneksi internet',
          SlowConnectionFailure() => 'Koneksi internet lambat',
          _ => failure.message ?? 'Terjadi kesalahan saat mengambil data',
        };
        return false;
      },
      (data) async {
        return true;
      },
    );
  }

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

  Future<void> getProductId({required int id}) async {
    isLoading.value = true;

    final result = await _getProductById(id: id);

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
        products.value = data;
        print(products.value.id);
      },
    );
  }
}
