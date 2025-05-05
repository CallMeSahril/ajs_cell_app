import 'package:ajs_cell_app/app/domain/orders/entities/payment_fee_entities.dart';

class PaymentFeeModel extends PaymentFeeEntities {
  PaymentFeeModel({
    super.paymentMethod,
    super.paymentName,
    super.paymentImage,
    super.totalFee,
  });

  factory PaymentFeeModel.fromJson(Map<String, dynamic> json) =>
      PaymentFeeModel(
        paymentMethod: json["paymentMethod"],
        paymentName: json["paymentName"],
        paymentImage: json["paymentImage"],
        totalFee: json["totalFee"],
      );

  PaymentFeeEntities toEntity() => PaymentFeeEntities(
        paymentMethod: paymentMethod,
        paymentName: paymentName,
        paymentImage: paymentImage,
        totalFee: totalFee,
      );
}
