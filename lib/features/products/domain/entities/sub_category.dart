import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 2)
class SubCategory extends Equatable {
  final String id, name, description, categoryId;
  final double sale;

  const SubCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.categoryId,
    this.sale = 0.0,
  });

  @override
  List<Object> get props => [id, name, description, categoryId, sale];
}
