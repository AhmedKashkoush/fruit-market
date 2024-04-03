import 'package:dartz/dartz.dart';
import 'package:fruit_market/core/errors/failures.dart';
import 'package:fruit_market/features/products/domain/entities/category.dart';
import 'package:fruit_market/features/products/domain/entities/product.dart';
import 'package:fruit_market/features/products/domain/entities/sub_category.dart';

abstract class BaseProductsRepository {
  Future<Either<Failure, List<Product>>> getAllProductsInCategory(
    Category category,
  );

  Future<Either<Failure, List<Product>>> searchProductsByQuery(
    String query,
  );

  Future<Either<Failure, List<SubCategory>>> getAllSubCategoriesInCategory(
    Category category,
  );

  Future<Either<Failure, List<Category>>> getAllCategories();

  Future<Either<Failure, Unit>> addToFavourites(Product product);
  Future<Either<Failure, Unit>> removeFromFavourites(Product product);

  Future<Either<Failure, Unit>> addToCart(Product product);
  Future<Either<Failure, Unit>> removeFromCart(Product product);

  // Future<Either<Failure, Unit>> changeProductQuantity(Product product);
}
