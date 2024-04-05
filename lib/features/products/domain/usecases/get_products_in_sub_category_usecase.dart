import 'package:dartz/dartz.dart';
import 'package:fruit_market/core/errors/failures.dart';
import 'package:fruit_market/core/usecases/base_usecases.dart';
import 'package:fruit_market/features/products/domain/entities/product.dart';
import 'package:fruit_market/features/products/domain/entities/sub_category.dart';
import 'package:fruit_market/features/products/domain/repositories/base_products_repository.dart';

class GetProductsInSubCategoryUseCase
    extends OptionalParameterUseCase<List<Product>, SubCategory, Product?> {
  final BaseProductsRepository baseProductRepository;

  GetProductsInSubCategoryUseCase(this.baseProductRepository);

  @override
  Future<Either<Failure, List<Product>>> call(SubCategory params,
      [Product? optionalParams]) async {
    return await baseProductRepository.getProductsInSubCategory(
      params,
      optionalParams,
    );
  }

  @override
  List<Object?> get props => [baseProductRepository];
}
