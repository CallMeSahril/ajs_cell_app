import 'package:ajs_cell_app/app/core/errors/failure.dart';
import 'package:ajs_cell_app/app/domain/products/entities/category_products_entities.dart';
import 'package:ajs_cell_app/app/domain/products/repositories/products_repositories.dart';
import 'package:dartz/dartz.dart';

class GetCategoryProductAll {
  final ProductsRepositories repositories;
  GetCategoryProductAll(this.repositories);

  Future<Either<Failure, List<CategoryProductsEntities>>> call() {
    return repositories.productsCategory();
  }
}
