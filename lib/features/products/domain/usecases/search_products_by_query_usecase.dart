import 'package:dartz/dartz.dart';
import 'package:fruit_market/core/errors/failures.dart';
import 'package:fruit_market/core/usecases/base_usecases.dart';
import 'package:fruit_market/features/products/domain/entities/product.dart';
import 'package:fruit_market/features/products/domain/repositories/base_products_repository.dart';

class SearchProductsByQueryUseCase
    extends ParameterUseCase<List<Product>, String> {
  final BaseProductsRepository baseProductRepository;

  SearchProductsByQueryUseCase(this.baseProductRepository);

  @override
  Future<Either<Failure, List<Product>>> call(String params) async {
    return await baseProductRepository.searchProductsByQuery(params);
  }

  @override
  List<Object?> get props => [baseProductRepository];
}
