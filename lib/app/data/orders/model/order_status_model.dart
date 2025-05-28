class OrderStatusModel {
  final String merchantOrderId;
  final String reference;
  final String amount;
  final String fee;
  final String statusCode;
  final String statusMessage;

  OrderStatusModel({
    required this.merchantOrderId,
    required this.reference,
    required this.amount,
    required this.fee,
    required this.statusCode,
    required this.statusMessage,
  });

  factory OrderStatusModel.fromJson(Map<String, dynamic> json) {
    return OrderStatusModel(
      merchantOrderId: json['merchantOrderId'] ?? '',
      reference: json['reference'] ?? '',
      amount: json['amount'] ?? '',
      fee: json['fee'] ?? '',
      statusCode: json['statusCode'] ?? '',
      statusMessage: json['statusMessage'] ?? '',
    );
  }
}
