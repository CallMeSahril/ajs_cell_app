import 'package:ajs_cell_app/app/core/errors/failure.dart';
import 'package:ajs_cell_app/app/domain/carts/entities/add_cart_entities.dart';
import 'package:ajs_cell_app/app/domain/carts/repositories/repositories.dart';
import 'package:dartz/dartz.dart';

class PostCart {
  final CartsRepositories repositories;
  PostCart(this.repositories);

  Future<Either<Failure, bool>> call({required AddCartEntities post}) {
    return repositories.addCart(post: post);
  }
}
