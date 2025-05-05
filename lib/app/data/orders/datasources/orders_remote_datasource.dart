import 'package:ajs_cell_app/app/core/api_helper/api_helper.dart';
import 'package:ajs_cell_app/app/core/errors/failure.dart';
import 'package:ajs_cell_app/app/core/utils/network_checker.dart';
import 'package:ajs_cell_app/app/data/orders/model/payment_fee_model.dart';
import 'package:ajs_cell_app/app/domain/orders/entities/create_orders_entitites.dart';
import 'package:dartz/dartz.dart';

class OrdersRemoteDatasource {
  final ApiHelper apiHelper = ApiHelper();

  Future<Either<Failure, bool>> createOrder(
      {required CreateOrdersEntitites post}) async {
    final isConnected = await NetworkChecker.isConnected();
    if (!isConnected) return Left(NoConnectionFailure());

    final isSlow = await NetworkChecker.isConnectionSlow();
    if (isSlow) return Left(SlowConnectionFailure());

    try {
      final response = await apiHelper.post('/orders', data: post.toJson());

      if (response.data == null || response.data['data'] == null) {
        return Left(ServerFailure("Data tidak ditemukan"));
      }

      final result = response.data['meta']['code'] == 200;
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<PaymentFeeModel>>> getPaymentMethod() async {
    final isConnected = await NetworkChecker.isConnected();
    if (!isConnected) return Left(NoConnectionFailure());

    final isSlow = await NetworkChecker.isConnectionSlow();
    if (isSlow) return Left(SlowConnectionFailure());

    try {
      final response =
          await apiHelper.post('/duitku/get-payment', data: {"paymentAmount": 5000});

      if (response.data == null || response.data['data'] == null) {
        return Left(ServerFailure("Data tidak ditemukan"));
      }

      final data = response.data['data']['paymentFee'] as List;
      final result =
          data.map((item) => PaymentFeeModel.fromJson(item)).toList();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
