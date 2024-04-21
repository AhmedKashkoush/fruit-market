part of 'view_all_products_bloc.dart';

class ViewAllProductsState extends Equatable {
  final List<Category> categories;
  final List<SubCategory> subCategories;
  final List<Product> products;
  final String error;
  final ViewAllProductsStatus categoriesStatus,
      subCategoriesStatus,
      productsStatus;
  const ViewAllProductsState({
    this.categories = const [],
    this.subCategories = const [],
    this.products = const [],
    this.error = '',
    this.categoriesStatus = ViewAllProductsStatus.initial,
    this.subCategoriesStatus = ViewAllProductsStatus.initial,
    this.productsStatus = ViewAllProductsStatus.initial,
  });

  ViewAllProductsState copyWith({
    List<Category>? categories,
    List<SubCategory>? subCategories,
    List<Product>? products,
    String? error,
    ViewAllProductsStatus? categoriesStatus,
    ViewAllProductsStatus? subCategoriesStatus,
    ViewAllProductsStatus? productsStatus,
  }) {
    return ViewAllProductsState(
      categories: categories ?? this.categories,
      subCategories: subCategories ?? this.subCategories,
      products: products ?? this.products,
      error: error ?? this.error,
      categoriesStatus: categoriesStatus ?? this.categoriesStatus,
      subCategoriesStatus: subCategoriesStatus ?? this.subCategoriesStatus,
      productsStatus: productsStatus ?? this.productsStatus,
    );
  }

  @override
  List<Object> get props => [
        categories,
        subCategories,
        products,
        error,
        categoriesStatus,
        subCategoriesStatus,
        productsStatus,
      ];
}

enum ViewAllProductsStatus {
  initial,
  loading,
  success,
  failure,
}
