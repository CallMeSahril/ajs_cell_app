import 'package:ajs_cell_app/app/core/errors/failure.dart';
import 'package:ajs_cell_app/app/domain/products/entities/product_entities.dart';
import 'package:ajs_cell_app/app/domain/products/usescases/get_category_product_by_id.dart';
import 'package:get/get.dart';

class DetailKatagoriController extends GetxController {
  final String title;
  final int id;
  final GetCategoryProductById _getCategoryProductById;
  DetailKatagoriController(
      {required this.title,
      required this.id,
      required GetCategoryProductById getCategoryProductById})
      : _getCategoryProductById = getCategoryProductById;

  List<ProductEntities> productEntities = [];
  Future<void> getCategoryProductById({required int id}) async {
    final result = await _getCategoryProductById(id: id);

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
        productEntities = data;
      },
    );
  }
}
