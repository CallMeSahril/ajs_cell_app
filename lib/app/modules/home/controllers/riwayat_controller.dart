import 'package:ajs_cell_app/app/core/errors/failure.dart';
import 'package:ajs_cell_app/app/data/orders/datasources/orders_remote_datasource.dart';
import 'package:ajs_cell_app/app/data/orders/model/orders_status_model.dart';
import 'package:ajs_cell_app/app/domain/orders/usescases/get_pending_order.dart';
import 'package:get/get.dart';

class RiwayatController extends GetxController {
  GetPendingOrder _getPendingOrder = GetPendingOrder();

  Future<List<OrderStatusEntities>> getPending(
      {required OrderStatus status}) async {
    final result = await _getPendingOrder(status: status);
    return result.fold(
      (failure) {
        String message = switch (failure) {
          NoConnectionFailure() => 'Tidak ada koneksi internet',
          SlowConnectionFailure() => 'Koneksi internet lambat',
          _ => failure.message ?? 'Terjadi kesalahan saat mengambil data',
        };
        return [];
      },
      (data) async {
        return data;
      },
    );
  }
}
