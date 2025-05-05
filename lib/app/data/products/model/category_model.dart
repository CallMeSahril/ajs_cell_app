import 'package:ajs_cell_app/app/domain/products/entities/category_products_entities.dart';

class CategoryModel extends CategoryProductsEntities {
  CategoryModel({super.createdAt, super.id, super.name, super.updatedAt});

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        name: json["name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  CategoryProductsEntities toEntity() {
    return CategoryProductsEntities(
        createdAt: createdAt, id: id, name: name, updatedAt: updatedAt);
  }
}
