import 'package:ajs_cell_app/app/data/address/datasources/address_remote_datasource.dart';
import 'package:ajs_cell_app/app/data/rajaongkir/datasources/rajaongkir_remote_datasource.dart';
import 'package:ajs_cell_app/app/domain/address/usescases/add_address.dart';
import 'package:ajs_cell_app/app/domain/address/usescases/delete_address.dart';
import 'package:ajs_cell_app/app/domain/address/usescases/get_address.dart';
import 'package:ajs_cell_app/app/domain/address/usescases/update_address.dart';
import 'package:ajs_cell_app/app/domain/carts/repositories/repositories.dart';
import 'package:ajs_cell_app/app/domain/carts/usescases/delete_cart.dart';
import 'package:ajs_cell_app/app/domain/carts/usescases/get_cart.dart';
import 'package:ajs_cell_app/app/domain/carts/usescases/post_cart.dart';
import 'package:ajs_cell_app/app/domain/carts/usescases/update_quantity.dart';
import 'package:ajs_cell_app/app/domain/orders/repositories/repositories.dart';
import 'package:ajs_cell_app/app/domain/orders/usescases/create_order.dart';
import 'package:ajs_cell_app/app/domain/orders/usescases/get_payment_method.dart';
import 'package:ajs_cell_app/app/domain/rajaongkir/usescases/get_city.dart';
import 'package:ajs_cell_app/app/domain/rajaongkir/usescases/get_province.dart';
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
    Get.lazyPut<CreateOrder>(
      () => CreateOrder(Get.find<OrdersRepositories>()),
    );
    Get.lazyPut<GetPaymentMethod>(
      () => GetPaymentMethod(Get.find<OrdersRepositories>()),
    );
    Get.lazyPut<RajaongkirRemoteDatasource>(
      () => RajaongkirRemoteDatasource(),
    );
    Get.lazyPut<GetProvince>(
      () => GetProvince(Get.find<RajaongkirRemoteDatasource>()),
    );
     Get.lazyPut<GetCity>(
      () => GetCity(Get.find<RajaongkirRemoteDatasource>()),
    );
    Get.lazyPut<AddressRemoteDatasource>(
      () => AddressRemoteDatasource(),
    );
    Get.lazyPut<AddAddress>(
      () => AddAddress(Get.find<AddressRemoteDatasource>()),
    );
    Get.lazyPut<DeleteAddress>(
      () => DeleteAddress(Get.find<AddressRemoteDatasource>()),
    );
    Get.lazyPut<GetAddress>(
      () => GetAddress(Get.find<AddressRemoteDatasource>()),
    );
    Get.lazyPut<UpdateAddress>(
      () => UpdateAddress(Get.find<AddressRemoteDatasource>()),
    );
    Get.lazyPut<KeranjangController>(
      () => KeranjangController(
        getCity: Get.find<GetCity>(),
        addAddress: Get.find<AddAddress>(),
        deleteAddress: Get.find<DeleteAddress>(),
        getAddress: Get.find<GetAddress>(),
        updateAddress: Get.find<UpdateAddress>(),
        getCart: Get.find<GetCart>(),
        deleteCart: Get.find<DeleteCart>(),
        postCart: Get.find<PostCart>(),
        updateQuantity: Get.find<UpdateQuantity>(),
        createOrder: Get.find<CreateOrder>(),
        getPaymentMethod: Get.find<GetPaymentMethod>(),
        getProvince: Get.find<GetProvince>(),
      ),
    );
  }
}
