import 'package:ajs_cell_app/app/core/errors/failure.dart';
import 'package:ajs_cell_app/app/domain/orders/entities/create_orders_entitites.dart';
import 'package:ajs_cell_app/app/domain/orders/repositories/repositories.dart';
import 'package:dartz/dartz.dart';

class CreateOrder {
  final OrdersRepositories repositories;
  CreateOrder(this.repositories);

  Future<Either<Failure, bool>> call({required CreateOrdersEntitites post}) {
    return repositories.createOrder(post: post);
  }
}
