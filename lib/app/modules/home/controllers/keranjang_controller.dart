import 'package:ajs_cell_app/app/core/errors/failure.dart';
import 'package:ajs_cell_app/app/data/address/model/addres_model.dart';
import 'package:ajs_cell_app/app/data/rajaongkir/model/city_model.dart';
import 'package:ajs_cell_app/app/data/rajaongkir/model/province_model.dart';
import 'package:ajs_cell_app/app/domain/address/entities/create_addres_entities.dart';
import 'package:ajs_cell_app/app/domain/address/usescases/add_address.dart';
import 'package:ajs_cell_app/app/domain/address/usescases/delete_address.dart';
import 'package:ajs_cell_app/app/domain/address/usescases/get_address.dart';
import 'package:ajs_cell_app/app/domain/address/usescases/update_address.dart';
import 'package:ajs_cell_app/app/domain/carts/entities/add_cart_entities.dart';
import 'package:ajs_cell_app/app/domain/carts/entities/cart_entities.dart';
import 'package:ajs_cell_app/app/domain/carts/usescases/delete_cart.dart';
import 'package:ajs_cell_app/app/domain/carts/usescases/get_cart.dart';
import 'package:ajs_cell_app/app/domain/carts/usescases/post_cart.dart';
import 'package:ajs_cell_app/app/domain/carts/usescases/update_quantity.dart';
import 'package:ajs_cell_app/app/domain/orders/entities/create_orders_entitites.dart';
import 'package:ajs_cell_app/app/domain/orders/entities/payment_fee_entities.dart';
import 'package:ajs_cell_app/app/domain/orders/usescases/create_order.dart';
import 'package:ajs_cell_app/app/domain/orders/usescases/get_payment_method.dart';
import 'package:ajs_cell_app/app/domain/rajaongkir/usescases/get_city.dart';
import 'package:ajs_cell_app/app/domain/rajaongkir/usescases/get_province.dart';
import 'package:get/get.dart';

class KeranjangController extends GetxController {
  final GetCart _getCart;
  final DeleteCart _deleteCart;
  final PostCart _postCart;
  final UpdateQuantity _updateQuantity;
  final CreateOrder _createOrder;
  final GetPaymentMethod _getPaymentMethod;
  final GetProvince _getProvince;
  final GetCity _getCity;
  final GetAddress _getAddress;
  final AddAddress _addAddress;
  final DeleteAddress _deleteAddress;
  final UpdateAddress _updateAddress;
  KeranjangController({
    required GetCart getCart,
    required DeleteCart deleteCart,
    required PostCart postCart,
    required UpdateQuantity updateQuantity,
    required CreateOrder createOrder,
    required GetPaymentMethod getPaymentMethod,
    required GetProvince getProvince,
    required GetAddress getAddress,
    required AddAddress addAddress,
    required DeleteAddress deleteAddress,
    required UpdateAddress updateAddress,
    required GetCity getCity,
  })  : _getCart = getCart,
        _deleteCart = deleteCart,
        _postCart = postCart,
        _updateQuantity = updateQuantity,
        _createOrder = createOrder,
        _getPaymentMethod = getPaymentMethod,
        _getProvince = getProvince,
        _getAddress = getAddress,
        _addAddress = addAddress,
        _deleteAddress = deleteAddress,
        _getCity = getCity,
        _updateAddress = updateAddress;

  List<CartEntities> cart = [];

  Future<bool> addAddress({required CreateAddressEntities post}) async {
    final result = await _addAddress(createAddressEntities: post);
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

  Future<List<CityEntities>> getCity({required int id}) async {
    final result = await _getCity(id: id);
    return result.fold(
      (failure) {
        String message = switch (failure) {
          NoConnectionFailure() => 'Tidak ada koneksi internet',
          SlowConnectionFailure() => 'Koneksi internet lambat',
          _ => failure.message ?? 'Terjadi kesalahan saat mengambil data',
        };
        return [];
      },
      (data) async {
        return data;
      },
    );
  }

  Future<List<AddressEntities>> getAddress() async {
    final result = await _getAddress();
    return result.fold(
      (failure) {
        String message = switch (failure) {
          NoConnectionFailure() => 'Tidak ada koneksi internet',
          SlowConnectionFailure() => 'Koneksi internet lambat',
          _ => failure.message ?? 'Terjadi kesalahan saat mengambil data',
        };
        return [];
      },
      (data) async {
        return data;
      },
    );
  }

  Future<List<PaymentFeeEntities>> getPaymentMethod() async {
    final result = await _getPaymentMethod();
    return result.fold(
      (failure) {
        String message = switch (failure) {
          NoConnectionFailure() => 'Tidak ada koneksi internet',
          SlowConnectionFailure() => 'Koneksi internet lambat',
          _ => failure.message ?? 'Terjadi kesalahan saat mengambil data',
        };
        return [];
      },
      (data) async {
        return data;
      },
    );
  }

  Future<List<ProvinceEntities>> getProvince() async {
    final result = await _getProvince();
    return result.fold(
      (failure) {
        String message = switch (failure) {
          NoConnectionFailure() => 'Tidak ada koneksi internet',
          SlowConnectionFailure() => 'Koneksi internet lambat',
          _ => failure.message ?? 'Terjadi kesalahan saat mengambil data',
        };
        return [];
      },
      (data) async {
        return data;
      },
    );
  }

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

  Future<bool> createOrder({required CreateOrdersEntitites post}) async {
    final result = await _createOrder(post: post);
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
