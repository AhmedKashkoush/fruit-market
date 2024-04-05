part of 'home_bloc.dart';

class HomeState extends Equatable {
  final List<Category> categories;
  final List<Map<SubCategory, List<Product>>> productsInSubCategories;
  final HomeStatus status;
  final String error;
  const HomeState({
    required this.categories,
    required this.productsInSubCategories,
    this.status = HomeStatus.initial,
    this.error = '',
  });

  HomeState copyWith({
    List<Category>? categories,
    List<Map<SubCategory, List<Product>>>? productsInSubCategories,
    HomeStatus? status,
    String? error,
  }) {
    return HomeState(
      categories: categories ?? this.categories,
      productsInSubCategories:
          productsInSubCategories ?? this.productsInSubCategories,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props =>
      [categories, productsInSubCategories, status, error];
}

enum HomeStatus {
  initial,
  loading,
  success,
  failure,
}
