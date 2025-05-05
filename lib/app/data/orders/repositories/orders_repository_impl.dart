import 'package:ajs_cell_app/app/core/errors/failure.dart';
import 'package:ajs_cell_app/app/data/orders/datasources/orders_remote_datasource.dart';
import 'package:ajs_cell_app/app/domain/orders/entities/create_orders_entitites.dart';
import 'package:ajs_cell_app/app/domain/orders/entities/payment_fee_entities.dart';
import 'package:ajs_cell_app/app/domain/orders/repositories/orders_repositories.dart';
import 'package:dartz/dartz.dart';

class OrdersRepositoryImpl implements OrdersRepositories {
  final OrdersRemoteDatasource remoteDatasource;

  OrdersRepositoryImpl(this.remoteDatasource);
  @override
  Future<Either<Failure, bool>> createOrder(
      {required CreateOrdersEntitites post}) async {
    final result = await remoteDatasource.createOrder(post: post);
    return result;
  }

  @override
  Future<Either<Failure, List<PaymentFeeEntities>>> getPaymentMethod() async {
    final result = await remoteDatasource.getPaymentMethod();
    return result;
  }
}
