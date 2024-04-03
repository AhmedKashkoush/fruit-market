import 'package:dartz/dartz.dart';
import 'package:fruit_market/core/errors/failures.dart';
import 'package:fruit_market/core/usecases/base_usecases.dart';
import 'package:fruit_market/features/products/domain/entities/category.dart';
import 'package:fruit_market/features/products/domain/repositories/base_products_repository.dart';

class GetAllCategoriesUseCase extends NoParameterUseCase<List<Category>> {
  final BaseProductsRepository baseProductRepository;

  GetAllCategoriesUseCase(this.baseProductRepository);

  @override
  Future<Either<Failure, List<Category>>> call() async {
    return await baseProductRepository.getAllCategories();
  }

  @override
  List<Object?> get props => [baseProductRepository];
}
