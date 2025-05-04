import 'package:ajs_cell_app/app/data/products/datasource/products_remote_datasource.dart';
import 'package:ajs_cell_app/app/data/products/repositories/products_repository_impl.dart';
import 'package:ajs_cell_app/app/domain/products/repositories/repositories.dart';
import 'package:get/get.dart';

class ProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductsRepositories>(
      () => ProductsRepositoryImpl(ProductsRemoteDatasource()),
    );
  }
}
