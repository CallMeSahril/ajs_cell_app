import 'package:ajs_cell_app/app/core/errors/failure.dart';
import 'package:ajs_cell_app/app/domain/carts/entities/add_cart_entities.dart';
import 'package:ajs_cell_app/app/domain/carts/entities/cart_entities.dart';
import 'package:ajs_cell_app/app/domain/carts/usescases/delete_cart.dart';
import 'package:ajs_cell_app/app/domain/carts/usescases/get_cart.dart';
import 'package:ajs_cell_app/app/domain/carts/usescases/post_cart.dart';
import 'package:ajs_cell_app/app/domain/carts/usescases/update_quantity.dart';
import 'package:get/get.dart';

class KeranjangController extends GetxController {
  final GetCart _getCart;
  final DeleteCart _deleteCart;
  final PostCart _postCart;
  final UpdateQuantity _updateQuantity;

  KeranjangController(
      {required GetCart getCart,
      required DeleteCart deleteCart,
      required PostCart postCart,
      required UpdateQuantity updateQuantity})
      : _getCart = getCart,
        _deleteCart = deleteCart,
        _postCart = postCart,
        _updateQuantity = updateQuantity;

  List<CartEntities> cart = [];
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

  Future<bool> deleteCart({required int id}) async {
    final result = await _deleteCart(id: id);
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

  Future<bool> updateQuantity({required int id, required int quantity}) async {
    final result = await _updateQuantity(id: id, quantity: quantity);
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

  Future<void> getCart() async {
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
