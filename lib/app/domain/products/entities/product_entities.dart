import 'package:ajs_cell_app/app/domain/products/entities/product_type_entities.dart';

class ProductEntities {
  final int? id;
  final String? name;
  final String? image;
  final int? stock;
  final String? description;
  final int? categoryId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? range;
  final List<ProductType>? productTypes;

  ProductEntities({
    this.id,
    this.name,
    this.image,
    this.stock,
    this.description,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
    this.range,
    this.productTypes,
  });
  factory ProductEntities.fromJson(Map<String, dynamic> json) =>
      ProductEntities(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        stock: int.parse(json["stock"]),
        description: json["description"],
        categoryId: int.parse(json["category_id"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        range: json["Range"],
        productTypes: json["product_types"] == null
            ? []
            : List<ProductType>.from(
                json["product_types"]!.map((x) => ProductType.fromJson(x))),
      );
}
