import 'package:fruit_market/features/products/data/models/product_model.dart';
import 'package:fruit_market/features/products/domain/entities/sub_category.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'sub_category_model.g.dart';

@HiveType(typeId: 2)
class SubCategoryModel extends SubCategory {
  @HiveField(0)
  final String _id;

  @HiveField(1)
  final String _name;

  @HiveField(2)
  final String _description;

  @HiveField(3)
  final double _sale;

  @HiveField(4)
  final List<ProductModel> _products;

  const SubCategoryModel({
    required String id,
    required String name,
    required String description,
    required List<ProductModel> products,
    double sale = 0.0,
  })  : _id = id,
        _name = name,
        _description = description,
        _products = products,
        _sale = sale,
        super(
          id: id,
          name: name,
          description: description,
          products: products,
        );

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      products: List<ProductModel>.from(
        json['products'].map(
          (e) => ProductModel.fromJson(e),
        ),
      ),
      sale: json['sale'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'name': _name,
      'description': _description,
      'products': _products.map((e) => e.toJson()).toList(),
      'sale': _sale,
    };
  }

  factory SubCategoryModel.fromEntity(SubCategory entity) {
    return SubCategoryModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      products: entity.products.map((e) => ProductModel.fromEntity(e)).toList(),
      sale: entity.sale,
    );
  }
}
