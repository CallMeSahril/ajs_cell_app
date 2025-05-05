import 'package:ajs_cell_app/app/core/errors/failure.dart';
import 'package:ajs_cell_app/app/domain/carts/entities/cart_entities.dart';
import 'package:ajs_cell_app/app/domain/carts/repositories/repositories.dart';
import 'package:dartz/dartz.dart';

class GetCart {
  final CartsRepositories repositories;
  GetCart(this.repositories);

  Future<Either<Failure, List<CartEntities>>> call() {
    return repositories.getCart();
  }
}
