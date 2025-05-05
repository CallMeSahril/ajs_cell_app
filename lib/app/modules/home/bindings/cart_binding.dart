import 'package:ajs_cell_app/app/data/carts/datasources/cart_remote_datasource.dart';
import 'package:ajs_cell_app/app/data/carts/repositories/cart_repository_impl.dart';
import 'package:ajs_cell_app/app/domain/carts/repositories/carts_repositories.dart';
import 'package:get/get.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartsRepositories>(
      () => CartRepositoryImpl(CartRemoteDatasource()),
    );
  }
}
