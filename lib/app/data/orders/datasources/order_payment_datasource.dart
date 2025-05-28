import 'package:ajs_cell_app/app/core/api_helper/api_helper.dart';
import 'package:ajs_cell_app/app/core/errors/failure.dart';
import 'package:ajs_cell_app/app/core/utils/network_checker.dart';
import 'package:ajs_cell_app/app/data/orders/model/order_status_model.dart';
import 'package:dartz/dartz.dart';

class OrderPaymentDatasource {
  final ApiHelper apiHelper = ApiHelper();

  Future<Either<Failure, OrderStatusModel>> getPendingOrderStatus() async {
    final isConnected = await NetworkChecker.isConnected();
    if (!isConnected) return Left(NoConnectionFailure());

    final isSlow = await NetworkChecker.isConnectionSlow();
    if (isSlow) return Left(SlowConnectionFailure());

    try {
      final response = await apiHelper.get('/orders/pending');
      if (response.data == null || response.data['data'] == null) {
        return Left(ServerFailure("Data tidak ditemukan"));
      }

      final result = OrderStatusModel.fromJson(response.data['data']);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  Future<Either<Failure, OrderStatusModel>> checkPaymentStatus(String merchantOrderId) async {
  try {
    final response = await apiHelper.post('/duitku/check-payment', data: {
      "merchant_order_id": merchantOrderId,
    });

    if (response.data['isSuccess'] == true && response.data['data'] != null) {
      final result = OrderStatusModel.fromJson(response.data['data']);
      return Right(result);
    } else {
      return Left(ServerFailure(response.data['message'] ?? 'Gagal cek status pembayaran'));
    }
  } catch (e) {
    return Left(ServerFailure(e.toString()));
  }
}

}
