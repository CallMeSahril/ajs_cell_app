import 'package:ajs_cell_app/app/core/errors/failure.dart';
import 'package:ajs_cell_app/app/data/orders/datasources/orders_remote_datasource.dart';
import 'package:ajs_cell_app/app/data/orders/model/history_model.dart';
import 'package:dartz/dartz.dart';

class GetHistory {
  final OrdersRemoteDatasource repositories = OrdersRemoteDatasource();

  Future<Either<Failure, List<HistoryEntities>>> call() {
    return repositories.getHistory();
  }
}
