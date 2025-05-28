import 'package:ajs_cell_app/app/data/orders/datasources/order_payment_datasource.dart';
import 'package:ajs_cell_app/app/data/orders/model/order_status_model.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  final OrderPaymentDatasource _remoteDatasource = OrderPaymentDatasource();

  var isLoading = false.obs;
  var orderStatus = Rxn<OrderStatusModel>();
  var errorMessage = ''.obs;

  Future<void> fetchPendingOrderStatus() async {
    isLoading.value = true;
    errorMessage.value = '';
    final result = await _remoteDatasource.getPendingOrderStatus();
    result.fold(
      (failure) => errorMessage.value = failure.message ?? 'Unknown error',
      (data) => orderStatus.value = data,
    );
    isLoading.value = false;
  }
  Future<void> checkPaymentStatus(String merchantOrderId) async {
  isLoading.value = true;
  errorMessage.value = '';

  final result = await _remoteDatasource.checkPaymentStatus(merchantOrderId);

  result.fold(
    (failure) => errorMessage.value = failure.message ?? 'Unknown error',
    (data) => orderStatus.value = data,
  );

  isLoading.value = false;
}

}
