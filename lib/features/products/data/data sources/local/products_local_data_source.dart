import 'package:fruit_market/core/errors/exceptions.dart';
import 'package:fruit_market/features/products/data/models/category_model.dart';
import 'package:fruit_market/features/products/data/models/product_model.dart';
import 'package:fruit_market/features/products/data/models/sub_category_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class BaseProductsLocalDataSource {
  List<ProductModel> getAllProductsInCategory(
    CategoryModel category,
  );

  List<SubCategoryModel> getAllSubCategoriesInCategory(
    CategoryModel category,
  );

  List<CategoryModel> getAllCategories();

  void saveCategories(List<CategoryModel> categories);
  void saveSubCategoriesInCategory(
      List<SubCategoryModel> subCategories, CategoryModel category);
  void saveProductsInCategory(
      List<ProductModel> products, CategoryModel category);

  void addToCart(ProductModel product);
  void removeFromCart(ProductModel product);

  void addToFavourites(ProductModel product);
  void removeFromFavourites(ProductModel product);
}

class ProductsLocalDataSource implements BaseProductsLocalDataSource {
  final Box<CategoryModel> categoryBox;
  final Box<SubCategoryModel> subCategoryBox;
  final Box<ProductModel> productBox;

  ProductsLocalDataSource(
    this.categoryBox,
    this.subCategoryBox,
    this.productBox,
  );

  @override
  void addToCart(ProductModel product) {}
  @override
  void addToFavourites(ProductModel product) {}
  @override
  void removeFromCart(ProductModel product) {}

  @override
  void removeFromFavourites(ProductModel product) {}

  @override
  List<CategoryModel> getAllCategories() {
    final List<CategoryModel> categories = categoryBox.values.toList();
    if (categories.isEmpty) {
      throw const CacheException('No categories found!');
    }
    return categories;
  }

  @override
  List<ProductModel> getAllProductsInCategory(
    CategoryModel category,
  ) {
    final List<ProductModel> products = productBox.values.toList();
    if (products.isEmpty) {
      throw const CacheException('No products found!');
    }
    return products;
  }

  @override
  List<SubCategoryModel> getAllSubCategoriesInCategory(
    CategoryModel category,
  ) {
    final List<SubCategoryModel> subCategories = subCategoryBox.values.toList();
    if (subCategories.isEmpty) {
      throw const CacheException('No sub categories found!');
    }
    return subCategories;
  }

  @override
  void saveCategories(List<CategoryModel> categories) {
    categoryBox.addAll(categories);
  }

  @override
  void saveProductsInCategory(
      List<ProductModel> products, CategoryModel category) {
    productBox.addAll(products);
  }

  @override
  void saveSubCategoriesInCategory(
      List<SubCategoryModel> subCategories, CategoryModel category) {
    subCategoryBox.addAll(subCategories);
  }
}
