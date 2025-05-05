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
        productTypeId: int.parse(json["product_type_id"]),
        productCart: json["product_cart"] == null
            ? null
            : ProductCartElement.fromJson(json["product_cart"]),
        quantity: int.parse(json["quantity"]),
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
