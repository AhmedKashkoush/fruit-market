
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
  final String _categoryId;

  const SubCategoryModel({
    required String id,
    required String name,
    required String description,
    required String categoryId,
    double sale = 0.0,
  })  : _id = id,
        _name = name,
        _description = description,
        _sale = sale,
        _categoryId = categoryId,
        super(
          id: id,
          name: name,
          description: description,
          categoryId: categoryId,
        );

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      sale: json['sale'],
      categoryId: json['categoryId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'name': _name,
      'description': _description,
      'sale': _sale,
      'categoryId': _categoryId,
    };
  }

  factory SubCategoryModel.fromEntity(SubCategory entity) {
    return SubCategoryModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      sale: entity.sale,
      categoryId: entity.categoryId,
    );
  }
}
