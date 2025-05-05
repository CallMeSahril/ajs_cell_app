import 'package:ajs_cell_app/app/core/errors/failure.dart';
import 'package:ajs_cell_app/app/domain/products/entities/product_entities.dart';
import 'package:ajs_cell_app/app/domain/products/repositories/products_repositories.dart';
import 'package:dartz/dartz.dart';

class GetCategoryProductById {
  final ProductsRepositories repositories;
  GetCategoryProductById(this.repositories);

  Future<Either<Failure, List<ProductEntities>>> call({required int id}) {
    return repositories.productCategoryById(id: id);
  }
}
