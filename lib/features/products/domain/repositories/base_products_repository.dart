import 'package:dartz/dartz.dart';
import 'package:fruit_market/core/errors/failures.dart';
import 'package:fruit_market/features/products/domain/entities/category.dart';
import 'package:fruit_market/features/products/domain/entities/product.dart';
import 'package:fruit_market/features/products/domain/entities/sub_category.dart';

abstract class BaseProductsRepository {
  Future<Either<Failure, List<Product>>> getProductsInSubCategory(
    SubCategory subCategory, [
    Product? startAfter,
  ]
  );

  Future<Either<Failure, List<Product>>> searchProductsByQuery(
    String query,
  );

  Future<Either<Failure, List<SubCategory>>> getSubCategoriesInCategory(
    Category category,
    [
    SubCategory? startAfter,
  ]
  );

  Future<Either<Failure, List<Category>>> getCategories([
    Category? startAfter,
  ]);

  Future<Either<Failure, Unit>> addToFavourites(Product product);
  Future<Either<Failure, Unit>> removeFromFavourites(Product product);

  Future<Either<Failure, Unit>> addToCart(Product product);
  Future<Either<Failure, Unit>> removeFromCart(Product product);

  // Future<Either<Failure, Unit>> changeProductQuantity(Product product);
}
