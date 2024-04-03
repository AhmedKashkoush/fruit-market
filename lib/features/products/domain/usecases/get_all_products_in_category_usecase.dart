import 'package:dartz/dartz.dart';
import 'package:fruit_market/core/errors/failures.dart';
import 'package:fruit_market/core/usecases/base_usecases.dart';
import 'package:fruit_market/features/products/domain/entities/category.dart';
import 'package:fruit_market/features/products/domain/entities/product.dart';
import 'package:fruit_market/features/products/domain/repositories/base_products_repository.dart';

class GetAllProductsInCategoryUseCase
    extends ParameterUseCase<List<Product>, Category> {
  final BaseProductsRepository baseProductRepository;

  GetAllProductsInCategoryUseCase(this.baseProductRepository);

  @override
  Future<Either<Failure, List<Product>>> call(Category params) async {
    return await baseProductRepository.getAllProductsInCategory(params);
  }

  @override
  List<Object?> get props => [baseProductRepository];
}
