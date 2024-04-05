import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruit_market/core/dummy/category_dummy.dart';
import 'package:fruit_market/core/dummy/product_dummy.dart';
import 'package:fruit_market/core/dummy/sub_category_dummy.dart';
import 'package:fruit_market/core/errors/exceptions.dart';
import 'package:fruit_market/features/products/data/models/category_model.dart';
import 'package:fruit_market/features/products/data/models/product_model.dart';
import 'package:fruit_market/features/products/data/models/sub_category_model.dart';

abstract class BaseProductsRemoteDataSource {
  Future<List<ProductModel>> getProductsInSubCategory(
    SubCategoryModel subCategory, [
    ProductModel? startAfter,
  ]
  );

  Future<List<ProductModel>> searchProductsByQuery(
    String query,
  );

  Future<List<SubCategoryModel>> getSubCategoriesInCategory(
    CategoryModel category,
    [
    SubCategoryModel? startAfter,
  ]
  );

  Future<List<CategoryModel>> getCategories([
    CategoryModel? startAfter,
  ]);

  Future<void> addToFavourites(ProductModel product);
  Future<void> removeFromFavourites(ProductModel product);

  Future<void> addToCart(ProductModel product);
  Future<void> removeFromCart(ProductModel product);
}

class ProductsRemoteDataSource implements BaseProductsRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore store;
  final Connectivity connectivity;

  ProductsRemoteDataSource(this.auth, this.store, this.connectivity);

  @override
  Future<void> addToCart(ProductModel product) async {
    final ConnectivityResult connectivityResult =
        await connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      throw const ConnectionException('Check your internet connection');
    }
  }

  @override
  Future<void> addToFavourites(ProductModel product) async {
    final ConnectivityResult connectivityResult =
        await connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      throw const ConnectionException('Check your internet connection');
    }
  }

  @override
  Future<List<CategoryModel>> getCategories([CategoryModel? startAfter]) async {
    final ConnectivityResult connectivityResult =
        await connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      throw const ConnectionException('Check your internet connection');
    }

    Future.delayed(
      const Duration(seconds: 3),
    );

    final List<CategoryModel> categories = CategoryDummy.categories
        .skip(
          startAfter != null
              ? CategoryDummy.categories.indexOf(startAfter) + 1
              : 0,
        )
        .take(4)
        .toList();

    return categories;
  }

  @override
  Future<List<ProductModel>> getProductsInSubCategory(
      SubCategoryModel subCategory,
      [ProductModel? startAfter]) async {
    final ConnectivityResult connectivityResult =
        await connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      throw const ConnectionException('Check your internet connection');
    }

    Future.delayed(
      const Duration(seconds: 3),
    );

    final List<ProductModel> products = ProductDummy.products
        .where((product) => product.subCategoryId == subCategory.id)
        .skip(
          startAfter != null
              ? ProductDummy.products.indexOf(startAfter) + 1
              : 0,
        )
        .take(5)
        .toList();


    return products;
  }

  @override
  Future<List<SubCategoryModel>> getSubCategoriesInCategory(
      CategoryModel category,
      [SubCategoryModel? startAfter]) async {
    final ConnectivityResult connectivityResult =
        await connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      throw const ConnectionException('Check your internet connection');
    }

    Future.delayed(
      const Duration(seconds: 3),
    );

    final List<SubCategoryModel> subCategories = SubCategoryDummy.subCategories
        .where((subCategory) => subCategory.categoryId == category.id)
        .skip(
          startAfter != null
              ? SubCategoryDummy.subCategories.indexOf(startAfter) + 1
              : 0,
        )
        .take(5)
        .toList();


    return subCategories;
  }

  @override
  Future<void> removeFromCart(ProductModel product) async {
    final ConnectivityResult connectivityResult =
        await connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      throw const ConnectionException('Check your internet connection');
    }
  }

  @override
  Future<void> removeFromFavourites(ProductModel product) async {
    final ConnectivityResult connectivityResult =
        await connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      throw const ConnectionException('Check your internet connection');
    }
  }

  @override
  Future<List<ProductModel>> searchProductsByQuery(String query) async {
    final ConnectivityResult connectivityResult =
        await connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      throw const ConnectionException('Check your internet connection');
    }

    final List<ProductModel> products = [];

    return products;
  }
}
