part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetCategoriesEvent extends HomeEvent {
  const GetCategoriesEvent();
}

class GetProductsEvent extends HomeEvent {
  final Category category;
  const GetProductsEvent(this.category);
}

class RefreshEvent extends HomeEvent {
  final Category category;
  const RefreshEvent(this.category);
}

class LoadMoreCategoriesEvent extends HomeEvent {
  final Category category, startAfter;
  const LoadMoreCategoriesEvent(
    this.category,
    this.startAfter,
  );
}

class LoadMoreSubCategoriesEvent extends HomeEvent {
  final Category category;
  final SubCategory startAfter;
  const LoadMoreSubCategoriesEvent(this.category, this.startAfter);
}
