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
  Future<Either<Failure, List<CategoryModel>>> getAllCategories() async {
    try {
      final List<CategoryModel> categories =
          await baseProductsRemoteDataSource.getAllCategories();
      baseProductsLocalDataSource.saveCategories(categories);
      return Right(categories);
    } on ConnectionException catch (e) {
      final List<CategoryModel> categories =
          baseProductsLocalDataSource.getAllCategories();
      if (categories.isNotEmpty) {
        return Right(categories);
      }
      return Left(
        ConnectionFailure(message: e.message),
      );
    } catch (e) {
      final List<CategoryModel> categories =
          baseProductsLocalDataSource.getAllCategories();
      if (categories.isNotEmpty) {
        return Right(categories);
      }
      return const Left(
        ServerFailure(message: 'Something went wrong!'),
      );
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getAllProductsInCategory(
    Category category,
  ) async {
    try {
      final List<ProductModel> products = await baseProductsRemoteDataSource
          .getAllProductsInCategory(CategoryModel.fromEntity(category));
      baseProductsLocalDataSource.saveProductsInCategory(
          products, CategoryModel.fromEntity(category));
      return Right(products);
    } on ConnectionException catch (e) {
      final List<ProductModel> products =
          baseProductsLocalDataSource.getAllProductsInCategory(
        CategoryModel.fromEntity(category),
      );
      if (products.isNotEmpty) {
        return Right(products);
      }
      return Left(
        ConnectionFailure(message: e.message),
      );
    } catch (e) {
      final List<ProductModel> products =
          baseProductsLocalDataSource.getAllProductsInCategory(
        CategoryModel.fromEntity(category),
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
  Future<Either<Failure, List<SubCategoryModel>>> getAllSubCategoriesInCategory(
    Category category,
  ) async {
    try {
      final List<SubCategoryModel> subCategories =
          await baseProductsRemoteDataSource.getAllSubCategoriesInCategory(
              CategoryModel.fromEntity(category));
      baseProductsLocalDataSource.saveSubCategoriesInCategory(
          subCategories, CategoryModel.fromEntity(category));
      return Right(subCategories);
    } on ConnectionException catch (e) {
      final List<SubCategoryModel> subCategories = baseProductsLocalDataSource
          .getAllSubCategoriesInCategory(CategoryModel.fromEntity(category));
      if (subCategories.isNotEmpty) {
        return Right(subCategories);
      }
      return Left(
        ConnectionFailure(message: e.message),
      );
    } catch (e) {
      final List<SubCategoryModel> subCategories = baseProductsLocalDataSource
          .getAllSubCategoriesInCategory(CategoryModel.fromEntity(category));
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
