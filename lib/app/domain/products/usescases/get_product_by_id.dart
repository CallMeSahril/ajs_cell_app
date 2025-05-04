import 'package:ajs_cell_app/app/core/errors/failure.dart';
import 'package:ajs_cell_app/app/domain/products/entities/product_entities.dart';
import 'package:dartz/dartz.dart';

import '../repositories/repositories.dart';

class GetProductById {
  final ProductsRepositories repositories;
  GetProductById(this.repositories);

  Future<Either<Failure, ProductEntities>> call({required int id}) {
    return repositories.productsById(id: id);
  }
}
