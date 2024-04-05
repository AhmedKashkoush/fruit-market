import 'package:dartz/dartz.dart';
import 'package:fruit_market/core/errors/exceptions.dart';
import 'package:fruit_market/core/errors/failures.dart';
import 'package:fruit_market/features/products/data/data%20sources/local/products_local_data_source.dart';
import 'package:fruit_market/features/products/data/data%20sources/remote/products_remote_data_source.dart';
import 'package:fruit_market/features/products/data/models/category_model.dart';
import 'package:fruit_market/features/products/data/models/product_model.dart';
import 'package:fruit_market/features/products/data/models/sub_category_model.dart';
import 'package:fruit_market/features/products/domain/entities/category.dart';
import 'package:fruit_market/features/products/domain/entities/product.dart';
import 'package:fruit_market/features/products/domain/entities/sub_category.dart';
import 'package:fruit_market/features/products/domain/repositories/base_products_repository.dart';

class ProductsRepository implements BaseProductsRepository {
  final BaseProductsRemoteDataSource baseProductsRemoteDataSource;
  final BaseProductsLocalDataSource baseProductsLocalDataSource;

  ProductsRepository(
    this.baseProductsRemoteDataSource,
    this.baseProductsLocalDataSource,
  );

  @override
  Future<Either<Failure, Unit>> addToCart(Product product) async {
    try {
      await baseProductsRemoteDataSource
          .addToCart(ProductModel.fromEntity(product));
      baseProductsLocalDataSource.addToCart(ProductModel.fromEntity(product));
      return const Right(unit);
    } on ConnectionException catch (e) {
      return Left(
        ConnectionFailure(message: e.message),
      );
    } catch (e) {
      return const Left(
        ServerFailure(message: 'Something went wrong!'),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> addToFavourites(Product product) async {
    try {
      await baseProductsRemoteDataSource
          .addToFavourites(ProductModel.fromEntity(product));
      baseProductsLocalDataSource
          .addToFavourites(ProductModel.fromEntity(product));
      return const Right(unit);
    } on ConnectionException catch (e) {
      return Left(
        ConnectionFailure(message: e.message),
      );
    } catch (e) {
      return const Left(
        ServerFailure(message: 'Something went wrong!'),
      );
    }
  }

  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories(
      [Category? startAfter]) async {
    try {
      final CategoryModel? startAfterModel =
          startAfter != null ? CategoryModel.fromEntity(startAfter) : null;
      final List<CategoryModel> categories =
          await baseProductsRemoteDataSource.getCategories(startAfterModel);
      baseProductsLocalDataSource.saveCategories(categories);
      return Right(categories);
    } on ConnectionException catch (e) {
      final List<CategoryModel> categories =
          baseProductsLocalDataSource.getCategories();
      if (categories.isNotEmpty) {
        return Right(categories);
      }
      return Left(
        ConnectionFailure(message: e.message),
      );
    } catch (e) {
      final List<CategoryModel> categories =
          baseProductsLocalDataSource.getCategories();
      if (categories.isNotEmpty) {
        return Right(categories);
      }
      return const Left(
        ServerFailure(message: 'Something went wrong!'),
      );
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getProductsInSubCategory(
    SubCategory subCategory, [
    Product? startAfter,
  ]
  ) async {
    try {
      final ProductModel? startAfterModel =
          startAfter != null ? ProductModel.fromEntity(startAfter) : null;
      final List<ProductModel> products = await baseProductsRemoteDataSource
          .getProductsInSubCategory(
        SubCategoryModel.fromEntity(subCategory),
        startAfterModel,
      );
      baseProductsLocalDataSource.saveProductsInSubCategory(
          products, SubCategoryModel.fromEntity(subCategory));
      return Right(products);
    } on ConnectionException catch (e) {
      final List<ProductModel> products =
          baseProductsLocalDataSource.getProductsInSubCategory(
        SubCategoryModel.fromEntity(subCategory),
      );
      if (products.isNotEmpty) {
        return Right(products);
      }
      return Left(
        ConnectionFailure(message: e.message),
      );
    } catch (e) {
      final List<ProductModel> products =
          baseProductsLocalDataSource.getProductsInSubCategory(
        SubCategoryModel.fromEntity(subCategory),
      );
      if (products.isNotEmpty) {
        return Right(products);
      }
      return const Left(
        ServerFailure(message: 'Something went wrong!'),
      );
    }
  }

  @override
  Future<Either<Failure, List<SubCategoryModel>>> getSubCategoriesInCategory(
    Category category,
    [
    SubCategory? startAfter,
  ]
  ) async {
    try {
      final SubCategoryModel? startAfterModel =
          startAfter != null ? SubCategoryModel.fromEntity(startAfter) : null;
      final List<SubCategoryModel> subCategories =
          await baseProductsRemoteDataSource.getSubCategoriesInCategory(
        CategoryModel.fromEntity(category),
        startAfterModel,
      );
      baseProductsLocalDataSource.saveSubCategoriesInCategory(
          subCategories, CategoryModel.fromEntity(category));
      return Right(subCategories);
    } on ConnectionException catch (e) {
      final List<SubCategoryModel> subCategories = baseProductsLocalDataSource
          .getSubCategoriesInCategory(CategoryModel.fromEntity(category));
      if (subCategories.isNotEmpty) {
        return Right(subCategories);
      }
      return Left(
        ConnectionFailure(message: e.message),
      );
    } catch (e) {
      final List<SubCategoryModel> subCategories = baseProductsLocalDataSource
          .getSubCategoriesInCategory(CategoryModel.fromEntity(category));
      if (subCategories.isNotEmpty) {
        return Right(subCategories);
      }
      return const Left(
        ServerFailure(message: 'Something went wrong!'),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> removeFromCart(Product product) async {
    try {
      await baseProductsRemoteDataSource
          .removeFromCart(ProductModel.fromEntity(product));
      baseProductsLocalDataSource
          .removeFromCart(ProductModel.fromEntity(product));
      return const Right(unit);
    } on ConnectionException catch (e) {
      return Left(
        ConnectionFailure(message: e.message),
      );
    } catch (e) {
      return const Left(
        ServerFailure(message: 'Something went wrong!'),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> removeFromFavourites(Product product) async {
    try {
      await baseProductsRemoteDataSource
          .removeFromFavourites(ProductModel.fromEntity(product));
      baseProductsLocalDataSource
          .removeFromFavourites(ProductModel.fromEntity(product));
      return const Right(unit);
    } on ConnectionException catch (e) {
      return Left(
        ConnectionFailure(message: e.message),
      );
    } catch (e) {
      return const Left(
        ServerFailure(message: 'Something went wrong!'),
      );
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> searchProductsByQuery(
    String query,
  ) async {
    try {
      final List<ProductModel> products =
          await baseProductsRemoteDataSource.searchProductsByQuery(query);
      return Right(products);
    } on ConnectionException catch (e) {
      return Left(
        ConnectionFailure(message: e.message),
      );
    } catch (e) {
      return const Left(
        ServerFailure(message: 'Something went wrong!'),
      );
    }
  }
}
