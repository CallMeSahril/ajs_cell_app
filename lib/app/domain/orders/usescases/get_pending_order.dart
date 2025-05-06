import 'package:ajs_cell_app/app/core/errors/failure.dart';
import 'package:ajs_cell_app/app/data/orders/datasources/orders_remote_datasource.dart';
import 'package:ajs_cell_app/app/data/orders/model/orders_status_model.dart';
import 'package:dartz/dartz.dart';

class GetPendingOrder {
  final OrdersRemoteDatasource repositories = OrdersRemoteDatasource();

  Future<Either<Failure, List<OrderStatusEntities>>> call(
      {required OrderStatus status}) {
    return repositories.getPendingOrder(status: status);
  }
}
