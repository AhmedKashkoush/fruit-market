import 'package:dartz/dartz.dart';
import 'package:fruit_market/core/errors/failures.dart';
import 'package:fruit_market/core/usecases/base_usecases.dart';
import 'package:fruit_market/features/products/domain/entities/category.dart';
import 'package:fruit_market/features/products/domain/entities/sub_category.dart';
import 'package:fruit_market/features/products/domain/repositories/base_products_repository.dart';

class GetSubCategoriesInCategoryUseCase extends OptionalParameterUseCase<
    List<SubCategory>, Category, SubCategory?> {
  final BaseProductsRepository baseProductRepository;

  GetSubCategoriesInCategoryUseCase(this.baseProductRepository);

  @override
  Future<Either<Failure, List<SubCategory>>> call(Category params,
      [SubCategory? optionalParams]) async {
    return await baseProductRepository.getSubCategoriesInCategory(
      params,
      optionalParams,
    );
  }

  @override
  List<Object?> get props => [baseProductRepository];
}
