import 'package:equatable/equatable.dart';
import 'package:fruit_market/features/products/domain/entities/product.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 2)
class SubCategory extends Equatable {
  final String id, name, description;
  final double sale;
  final List<Product> products;

  const SubCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.products,
    this.sale = 0.0,
  });

  @override
  List<Object> get props => [id, name, description, products, sale];
}
