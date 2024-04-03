import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id, name, description, imageUrl;

  final double price, rate;

  final List<String> nutritions;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.rate,
    required this.nutritions,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        imageUrl,
        price,
        rate,
        nutritions,
      ];
}
