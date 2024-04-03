import 'package:dartz/dartz.dart';
import 'package:fruit_market/core/errors/failures.dart';
import 'package:fruit_market/core/usecases/base_usecases.dart';
import 'package:fruit_market/features/products/domain/entities/product.dart';
import 'package:fruit_market/features/products/domain/repositories/base_products_repository.dart';

class AddToCartUseCase extends ParameterUseCase<Unit, Product> {
  final BaseProductsRepository baseProductRepository;

  AddToCartUseCase(this.baseProductRepository);

  @override
  Future<Either<Failure, Unit>> call(Product params) async {
    return await baseProductRepository.addToCart(params);
  }

  @override
  List<Object?> get props => [baseProductRepository];
}