import 'package:ajs_cell_app/app/domain/products/entities/product_entities.dart';
import 'package:ajs_cell_app/app/domain/products/entities/product_type_entities.dart';

class ProductsModel extends ProductEntities {
  ProductsModel(
      {super.categoryId,
      super.createdAt,
      super.description,
      super.id,
      super.image,
      super.name,
      super.productTypes,
      super.range,
      super.stock,
      super.updatedAt,
      super.discount});
  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
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
              json["product_types"]!.map((x) => ProductType.fromJson(x)),
            ),
      discount: List<Discount>.from(
          json["discount"].map((x) => Discount.fromJson(x))),
    );
  }

  ProductEntities toEntity() {
    return ProductEntities(
        categoryId: categoryId,
        createdAt: createdAt,
        description: description,
        id: id,
        image: image,
        name: name,
        productTypes: productTypes,
        range: range,
        stock: stock,
        discount: discount,
        updatedAt: updatedAt);
  }
}
