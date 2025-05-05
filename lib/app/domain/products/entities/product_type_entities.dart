
class ProductType {
    final int? id;
    final int? productId;
    final String? type;
    final String? price;

    ProductType({
        this.id,
        this.productId,
        this.type,
        this.price,
    });

    factory ProductType.fromJson(Map<String, dynamic> json) => ProductType(
        id: json["id"],
        productId: int.parse(json["product_id"]),
        type: json["type"],
        price: json["price"],
    );

}