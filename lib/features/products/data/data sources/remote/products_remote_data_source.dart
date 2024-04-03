import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruit_market/core/errors/exceptions.dart';
import 'package:fruit_market/features/products/data/models/category_model.dart';
import 'package:fruit_market/features/products/data/models/product_model.dart';
import 'package:fruit_market/features/products/data/models/sub_category_model.dart';

abstract class BaseProductsRemoteDataSource {
  Future<List<ProductModel>> getAllProductsInCategory(
    CategoryModel category,
  );

  Future<List<ProductModel>> searchProductsByQuery(
    String query,
  );

  Future<List<SubCategoryModel>> getAllSubCategoriesInCategory(
    CategoryModel category,
  );

  Future<List<CategoryModel>> getAllCategories();

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
  Future<List<CategoryModel>> getAllCategories() async {
    final ConnectivityResult connectivityResult =
        await connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      throw const ConnectionException('Check your internet connection');
    }

    final List<CategoryModel> categories = [];

    return categories;
  }

  @override
  Future<List<ProductModel>> getAllProductsInCategory(
      CategoryModel category) async {
    final ConnectivityResult connectivityResult =
        await connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      throw const ConnectionException('Check your internet connection');
    }

    final List<ProductModel> products = [];

    return products;
  }

  @override
  Future<List<SubCategoryModel>> getAllSubCategoriesInCategory(
      CategoryModel category) async {
    final ConnectivityResult connectivityResult =
        await connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      throw const ConnectionException('Check your internet connection');
    }

    final List<SubCategoryModel> subCategories = [];

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
