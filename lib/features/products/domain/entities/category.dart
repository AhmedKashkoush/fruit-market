import 'package:equatable/equatable.dart';
import 'package:fruit_market/features/products/domain/entities/sub_category.dart';

class Category extends Equatable {
  final String id, name;

  final List<SubCategory> subCategories;

  const Category({
    required this.id,
    required this.name,
    required this.subCategories,
  });

  @override
  List<Object> get props => [id, name, subCategories];
}
