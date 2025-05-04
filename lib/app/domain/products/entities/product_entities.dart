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
}
