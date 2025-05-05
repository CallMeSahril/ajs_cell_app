import 'package:ajs_cell_app/app/data/orders/datasources/orders_remote_datasource.dart';
import 'package:ajs_cell_app/app/data/orders/repositories/orders_repository_impl.dart';
import 'package:ajs_cell_app/app/domain/orders/repositories/repositories.dart';
import 'package:get/get.dart';

class OrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrdersRepositories>(
      () => OrdersRepositoryImpl(OrdersRemoteDatasource()),
    );
  }
}
