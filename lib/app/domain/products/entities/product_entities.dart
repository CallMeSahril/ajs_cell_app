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
  final List<Discount>? discount;
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
    this.discount,
  });
  factory ProductEntities.fromJson(Map<String, dynamic> json) =>
      ProductEntities(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        stock: json["stock"],
        description: json["description"],
        categoryId: json["category_id"],
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
        discount: List<Discount>.from(
            json["discount"].map((x) => Discount.fromJson(x))),
      );
}

class Discount {
  int id;
  String productId;
  String potonganDiskon;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  Discount({
    required this.id,
    required this.productId,
    required this.potonganDiskon,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Discount.fromJson(Map<String, dynamic> json) => Discount(
        id: json["id"],
        productId: json["product_id"],
        potonganDiskon: json["potongan_diskon"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "potongan_diskon": potonganDiskon,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
