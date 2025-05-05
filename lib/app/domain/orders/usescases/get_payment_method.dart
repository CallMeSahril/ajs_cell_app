import 'package:ajs_cell_app/app/core/errors/failure.dart';
import 'package:ajs_cell_app/app/domain/orders/entities/payment_fee_entities.dart';
import 'package:ajs_cell_app/app/domain/orders/repositories/orders_repositories.dart';
import 'package:dartz/dartz.dart';

class GetPaymentMethod {
  final OrdersRepositories repositories;
  GetPaymentMethod(this.repositories);

  Future<Either<Failure, List<PaymentFeeEntities>>> call() {
    return repositories.getPaymentMethod();
  }
}
