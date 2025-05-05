class AddCartEntities {
  final int productId;
  final int quantity;
  final int productTypeId;

  AddCartEntities(
      {required this.productId,
      required this.quantity,
      required this.productTypeId});

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "quantity": quantity,
        "product_type_id": productTypeId,
      };
}
