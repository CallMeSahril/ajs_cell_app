import 'package:ajs_cell_app/app/core/errors/failure.dart';
import 'package:ajs_cell_app/app/data/carts/datasources/cart_remote_datasource.dart';
import 'package:ajs_cell_app/app/domain/carts/entities/add_cart_entities.dart';
import 'package:ajs_cell_app/app/domain/carts/entities/cart_entities.dart';
import 'package:ajs_cell_app/app/domain/carts/repositories/carts_repositories.dart';
import 'package:dartz/dartz.dart';

class CartRepositoryImpl implements CartsRepositories {
  final CartRemoteDatasource remoteDatasource;

  CartRepositoryImpl(this.remoteDatasource);
  @override
  Future<Either<Failure, bool>> addCart({required AddCartEntities post}) async {
    final result = await remoteDatasource.addCart(post: post);
    return result;
  }

  @override
  Future<Either<Failure, List<CartEntities>>> getCart() async {
    final result = await remoteDatasource.getCart();
    return result;
  }
}
