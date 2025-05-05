import 'package:ajs_cell_app/app/core/errors/failure.dart';
import 'package:ajs_cell_app/app/domain/carts/entities/add_cart_entities.dart';
import 'package:ajs_cell_app/app/domain/carts/entities/cart_entities.dart';

import 'package:dartz/dartz.dart';

abstract class CartsRepositories {
  Future<Either<Failure, bool>> addCart({required AddCartEntities post});
  Future<Either<Failure, bool>> deleteCart({required int id});
  Future<Either<Failure, bool>> updateQuantity(
      {required int id, required int quantity});
  Future<Either<Failure, List<CartEntities>>> getCart();
}
