import 'package:ajs_cell_app/app/core/errors/failure.dart';
import 'package:ajs_cell_app/app/domain/products/entities/category_products_entities.dart';
import 'package:ajs_cell_app/app/domain/products/usescases/get_category_product_all.dart';
import 'package:get/get.dart';

class KategoriController extends GetxController {
  final GetCategoryProductAll _getCategoryProductAll;

  KategoriController({required GetCategoryProductAll getCategoryProductAll})
      : _getCategoryProductAll = getCategoryProductAll;
  List<CategoryProductsEntities> productsCategory = [];
  Future<void> getCategoryProductAll() async {
    final result = await _getCategoryProductAll();

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
        productsCategory = data;
      },
    );
  }
}
