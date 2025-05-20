import 'package:ajs_cell_app/app/domain/carts/entities/cart_entities.dart';
import 'package:ajs_cell_app/app/domain/products/entities/product_entities.dart';

class CartModel extends CartEntities {
  CartModel(
      {super.cartId,
      super.product,
      super.productTypeId,
      super.quantity,
      super.productCart});

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        cartId: json["cart_id"],
        productTypeId: int.tryParse(json["product_type_id"].toString()) ?? 0,
        productCart: json["product_type"] == null
            ? null
            : ProductCartElement.fromJson(json["product_type"]),
        quantity: json["quantity"],
        product: json["product"] == null
            ? null
            : ProductEntities.fromJson(json["product"]),
      );
  CartEntities toEntity() {
    return CartEntities(
      productCart: productCart,
      cartId: cartId,
      product: product,
      productTypeId: productTypeId,
      quantity: quantity,
    );
  }
}
