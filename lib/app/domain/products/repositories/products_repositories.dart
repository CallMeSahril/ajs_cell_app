import 'package:ajs_cell_app/app/core/errors/failure.dart';
import 'package:ajs_cell_app/app/domain/products/entities/category_products_entities.dart';
import 'package:ajs_cell_app/app/domain/products/entities/product_entities.dart';
import 'package:dartz/dartz.dart';

abstract class ProductsRepositories {
  Future<Either<Failure, List<ProductEntities>>> productsAll();
  Future<Either<Failure, ProductEntities>> productsById({required int id});
  Future<Either<Failure, List<CategoryProductsEntities>>> productsCategory();
  Future<Either<Failure, List<ProductEntities>>>productCategoryById(
      {required int id});
}
