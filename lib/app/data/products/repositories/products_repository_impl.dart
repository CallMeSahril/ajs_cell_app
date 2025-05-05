import 'package:ajs_cell_app/app/core/errors/failure.dart';
import 'package:ajs_cell_app/app/data/products/datasource/products_remote_datasource.dart';
import 'package:ajs_cell_app/app/domain/products/entities/category_products_entities.dart';
import 'package:ajs_cell_app/app/domain/products/entities/product_entities.dart';
import 'package:ajs_cell_app/app/domain/products/repositories/repositories.dart';
import 'package:dartz/dartz.dart';

class ProductsRepositoryImpl implements ProductsRepositories {
  final ProductsRemoteDatasource remoteDatasource;

  ProductsRepositoryImpl(this.remoteDatasource);
  @override
  Future<Either<Failure, List<ProductEntities>>> productsAll() async {
    final result = await remoteDatasource.productsAll();
    return result
        .map((models) => models.map((model) => model.toEntity()).toList());
  }

  @override
  Future<Either<Failure, ProductEntities>> productsById(
      {required int id}) async {
    final result = await remoteDatasource.productsById(id: id);
    return result.map((model) => model.toEntity());
  }

  @override
  Future<Either<Failure, List<CategoryProductsEntities>>>
      productsCategory() async {
    final result = await remoteDatasource.productsCategory();
    return result
        .map((models) => models.map((model) => model.toEntity()).toList());
  }

  @override
  Future<Either<Failure, List<ProductEntities>>> productCategoryById(
      {required int id}) async {
    final result = await remoteDatasource.productCategoryById(id: id);
    return result
        .map((models) => models.map((model) => model.toEntity()).toList());
  }
}
