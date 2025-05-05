import 'package:ajs_cell_app/app/domain/products/entities/product_entities.dart';

class CartEntities {
  final int? cartId;
  final int? productTypeId;
  final ProductCartElement? productCart;
  final int? quantity;
  final ProductEntities? product;

  CartEntities({
    this.cartId,
    this.productTypeId,
    this.productCart,
    this.quantity,
    this.product,
  });
}

class ProductCartElement {
  final int? id;
  final int? productId;
  final String? type;
  final String? price;

  ProductCartElement({
    this.id,
    this.productId,
    this.type,
    this.price,
  });

  factory ProductCartElement.fromJson(Map<String, dynamic> json) =>
      ProductCartElement(
        id: json["id"],
        productId: int.parse(json["product_id"]),
        type: json["type"],
        price: json["price"],
      );
}
