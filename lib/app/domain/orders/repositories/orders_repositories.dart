import 'package:ajs_cell_app/app/core/errors/failure.dart';
import 'package:ajs_cell_app/app/domain/orders/entities/create_orders_entitites.dart';
import 'package:ajs_cell_app/app/domain/orders/entities/payment_fee_entities.dart';
import 'package:dartz/dartz.dart';

abstract class OrdersRepositories {
  Future<Either<Failure, bool>> createOrder(
      {required CreateOrdersEntitites post});

  Future<Either<Failure, List<PaymentFeeEntities>>> getPaymentMethod();
}
