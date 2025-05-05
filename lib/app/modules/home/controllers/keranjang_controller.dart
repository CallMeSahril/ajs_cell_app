import 'package:ajs_cell_app/app/core/errors/failure.dart';
import 'package:ajs_cell_app/app/domain/carts/entities/cart_entities.dart';
import 'package:ajs_cell_app/app/domain/carts/usescases/get_cart.dart';
import 'package:get/get.dart';

class KeranjangController extends GetxController {
  final GetCart _getCart;

  KeranjangController({required GetCart getCart}) : _getCart = getCart;

  List<CartEntities> cart = [];
  Future<void> getCategoryProductAll() async {
    final result = await _getCart();

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
        cart = data;
      },
    );
  }
}
