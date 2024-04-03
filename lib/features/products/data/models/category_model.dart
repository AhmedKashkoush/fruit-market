import 'package:fruit_market/features/products/data/models/sub_category_model.dart';
import 'package:fruit_market/features/products/domain/entities/category.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'category_model.g.dart';

@HiveType(typeId: 1)
class CategoryModel extends Category {
  @HiveField(0)
  final String _id;

  @HiveField(1)
  final String _name;

  @HiveField(2)
  final List<SubCategoryModel> _subCategories;

  const CategoryModel({
    required String id,
    required String name,
    required List<SubCategoryModel> subCategories,
  })  : _id = id,
        _name = name,
        _subCategories = subCategories,
        super(
          id: id,
          name: name,
          subCategories: subCategories,
        );

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      subCategories: (json['subCategories'] as List<Map<String, dynamic>>)
          .map(
            (subCategoryData) => SubCategoryModel.fromJson(subCategoryData),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'name': _name,
      'subCategories': _subCategories.map((e) => e.toJson()).toList(),
    };
  }

  factory CategoryModel.fromEntity(Category entity) {
    return CategoryModel(
      id: entity.id,
      name: entity.name,
      subCategories: entity.subCategories
          .map((e) => SubCategoryModel.fromEntity(e))
          .toList(),
    );
  }
}
