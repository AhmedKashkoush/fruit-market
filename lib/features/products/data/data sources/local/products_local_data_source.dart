import 'package:fruit_market/core/errors/exceptions.dart';
import 'package:fruit_market/features/products/data/models/category_model.dart';
import 'package:fruit_market/features/products/data/models/product_model.dart';
import 'package:fruit_market/features/products/data/models/sub_category_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class BaseProductsLocalDataSource {
  List<ProductModel> getProductsInSubCategory(
    SubCategoryModel subCategory,
  );

  List<SubCategoryModel> getSubCategoriesInCategory(
    CategoryModel category,
  );

  List<CategoryModel> getCategories();

  void saveCategories(List<CategoryModel> categories);
  void saveSubCategoriesInCategory(
      List<SubCategoryModel> subCategories, CategoryModel category);
  void saveProductsInSubCategory(
      List<ProductModel> products, SubCategoryModel subCategory);

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
  List<CategoryModel> getCategories() {
    final List<CategoryModel> categories = categoryBox.values.toList();
    if (categories.isEmpty) {
      throw const CacheException('No categories found!');
    }
    return categories;
  }

  @override
  List<ProductModel> getProductsInSubCategory(
    SubCategoryModel subCategory,
  ) {
    final List<ProductModel> products = productBox.values
        .where((product) => product.subCategoryId == subCategory.id)
        .toList();
    if (products.isEmpty) {
      throw const CacheException('No products found!');
    }
    return products;
  }

  @override
  List<SubCategoryModel> getSubCategoriesInCategory(
    CategoryModel category,
  ) {
    final List<SubCategoryModel> subCategories = subCategoryBox.values
        .where((subCategory) => subCategory.categoryId == category.id)
        .toList();
    if (subCategories.isEmpty) {
      throw const CacheException('No sub categories found!');
    }
    return subCategories;
  }

  @override
  void saveCategories(List<CategoryModel> categories) {
    categoryBox.clear();
    categoryBox.addAll(categories);
  }

  @override
  void saveProductsInSubCategory(
      List<ProductModel> products, SubCategoryModel subCategory) {
    List<int> keys = [];
    productBox.toMap().forEach((key, product) {
      if (product.subCategoryId == subCategory.id) {
        keys.add(key);
      }
    });
    productBox.deleteAll(keys);
    productBox.addAll(products);
  }

  @override
  void saveSubCategoriesInCategory(
      List<SubCategoryModel> subCategories, CategoryModel category) {
    List<int> keys = [];
    subCategoryBox.toMap().forEach((key, subCategory) {
      if (subCategory.categoryId == category.id) {
        keys.add(key);
      }
    });
    subCategoryBox.deleteAll(keys);
    subCategoryBox.addAll(subCategories);
  }
}
