import 'package:dartz/dartz.dart';
import 'package:fruit_market/core/errors/failures.dart';
import 'package:fruit_market/core/usecases/base_usecases.dart';
import 'package:fruit_market/features/products/domain/entities/category.dart';
import 'package:fruit_market/features/products/domain/repositories/base_products_repository.dart';

class GetCategoriesUseCase extends ParameterUseCase<List<Category>, Category?> {
  final BaseProductsRepository baseProductRepository;

  GetCategoriesUseCase(this.baseProductRepository);

  @override
  Future<Either<Failure, List<Category>>> call([Category? params]) async {
    return await baseProductRepository.getCategories(params);
  }

  @override
  List<Object?> get props => [baseProductRepository];
}
