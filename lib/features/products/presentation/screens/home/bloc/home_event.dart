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
