import 'package:fruit_market/features/products/domain/entities/category.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'category_model.g.dart';

@HiveType(typeId: 1)
class CategoryModel extends Category {
  @HiveField(0)
  final String _id;

  @HiveField(1)
  final String _name;


  const CategoryModel({
    required String id,
    required String name,
  })  : _id = id,
        _name = name,
        super(
          id: id,
          name: name,
        );

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'name': _name,
    };
  }

  factory CategoryModel.fromEntity(Category entity) {
    return CategoryModel(
      id: entity.id,
      name: entity.name,
    );
  }
}
