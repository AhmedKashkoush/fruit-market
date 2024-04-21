part of 'view_all_products_bloc.dart';

sealed class ViewAllProductsEvent extends Equatable {}

class ViewProductsInSubCategoryEvent extends ViewAllProductsEvent {
  final Category category;
  final SubCategory subCategory;
  final List<Category> initialCategories;
  final List<SubCategory> initialSubCategories;

  ViewProductsInSubCategoryEvent({
    required this.category,
    required this.subCategory,
    required this.initialCategories,
    required this.initialSubCategories,
  });

  @override
  List<Object?> get props => [
        category,
        subCategory,
        initialCategories,
        initialSubCategories,
      ];
}

class RefreshProductsEvent extends ViewAllProductsEvent {
  final SubCategory subCategory;

  RefreshProductsEvent({
    required this.subCategory,
  });

  @override
  List<Object?> get props => [subCategory];
}

class LoadMoreCategoriesEvent extends ViewAllProductsEvent {
  LoadMoreCategoriesEvent();
  @override
  List<Object?> get props => [];
}

class LoadMoreSubCategoriesEvent extends ViewAllProductsEvent {
  final Category category;

  LoadMoreSubCategoriesEvent({
    required this.category,
  });
  @override
  List<Object?> get props => [category];
}

class LoadMoreProductsEvent extends ViewAllProductsEvent {
  final SubCategory subCategory;

  LoadMoreProductsEvent({
    required this.subCategory,
  });
  @override
  List<Object?> get props => [subCategory];
}
