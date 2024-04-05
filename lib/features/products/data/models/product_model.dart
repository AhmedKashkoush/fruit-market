import 'package:fruit_market/features/products/domain/entities/product.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'product_model.g.dart';

@HiveType(typeId: 3)
class ProductModel extends Product {
  @HiveField(0)
  final String _id;

  @HiveField(1)
  final String _name;

  @HiveField(2)
  final String _description;

  @HiveField(3)
  final String _imageUrl;

  @HiveField(4)
  final double _price;

  @HiveField(5)
  final double _rate;

  @HiveField(6)
  final List<String> _nutritions;

  @HiveField(7)
  final String _subCategoryId;
  const ProductModel({
    required String id,
    required String name,
    required String description,
    required double price,
    required String imageUrl,
    required List<String> nutritions,
    required double rate,
    required String subCategoryId,
  })  : _id = id,
        _name = name,
        _description = description,
        _price = price,
        _imageUrl = imageUrl,
        _nutritions = nutritions,
        _rate = rate,
        _subCategoryId = subCategoryId,
        super(
          id: id,
          name: name,
          description: description,
          price: price,
          imageUrl: imageUrl,
          nutritions: nutritions,
          rate: rate,
          subCategoryId: subCategoryId,
        );
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      imageUrl: json['image'],
      nutritions: List.from(json['nutritions']),
      rate: json['rate'],
      subCategoryId: json['subCategoryId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'name': _name,
      'description': _description,
      'price': _price,
      'image': _imageUrl,
      'nutritions': _nutritions,
      'rate': _rate,
      'subCategory': _subCategoryId,
    };
  }

  factory ProductModel.fromEntity(Product product) {
    return ProductModel(
      id: product.id,
      name: product.name,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
      nutritions: product.nutritions,
      rate: product.rate,
      subCategoryId: product.subCategoryId,
    );
  }
}
