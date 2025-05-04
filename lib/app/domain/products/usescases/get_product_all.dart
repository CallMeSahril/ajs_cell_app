import 'package:ajs_cell_app/app/core/errors/failure.dart';
import 'package:ajs_cell_app/app/domain/products/entities/product_entities.dart';
import 'package:dartz/dartz.dart';

import '../repositories/repositories.dart';

class GetAllProducts {
  final ProductsRepositories repositories;
  GetAllProducts(this.repositories);

  Future<Either<Failure, List<ProductEntities>>> call() {
    return repositories.productsAll();
  }
}
