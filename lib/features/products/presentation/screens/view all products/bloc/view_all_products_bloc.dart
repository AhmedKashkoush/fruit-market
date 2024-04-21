import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_market/core/errors/failures.dart';
import 'package:fruit_market/features/products/domain/entities/category.dart';
import 'package:fruit_market/features/products/domain/entities/product.dart';
import 'package:fruit_market/features/products/domain/entities/sub_category.dart';
import 'package:fruit_market/features/products/domain/usecases/get_categories_usecase.dart';
import 'package:fruit_market/features/products/domain/usecases/get_products_in_sub_category_usecase.dart';
import 'package:fruit_market/features/products/domain/usecases/get_sub_categories_in_category_usecase.dart';

part 'view_all_products_event.dart';
part 'view_all_products_state.dart';

class ViewAllProductsBloc
    extends Bloc<ViewAllProductsEvent, ViewAllProductsState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetSubCategoriesInCategoryUseCase getSubCategoriesInCategoryUseCase;
  final GetProductsInSubCategoryUseCase getProductsInSubCategoryUseCase;
  ViewAllProductsBloc(
    this.getCategoriesUseCase,
    this.getSubCategoriesInCategoryUseCase,
    this.getProductsInSubCategoryUseCase,
  ) : super(const ViewAllProductsState()) {
    on<ViewProductsInSubCategoryEvent>(_viewProductsInSubCategory);
    on<RefreshProductsEvent>(_refreshProducts);
    on<LoadMoreCategoriesEvent>(
      _loadMoreCategories,
      transformer: droppable(),
    );
    on<LoadMoreSubCategoriesEvent>(
      _loadMoreSubCategories,
      transformer: droppable(),
    );
    on<LoadMoreProductsEvent>(
      _loadMoreProducts,
      transformer: droppable(),
    );
  }

  FutureOr<void> _viewProductsInSubCategory(
    ViewProductsInSubCategoryEvent event,
    Emitter<ViewAllProductsState> emit,
  ) async {
    emit(
      state.copyWith(
        categories: event.initialCategories,
        subCategories: event.initialSubCategories,
        products: [],
        productsStatus: ViewAllProductsStatus.loading,
      ),
    );

    final Either<Failure, List<Product>> productsResult =
        await getProductsInSubCategoryUseCase(event.subCategory);

    productsResult.fold(
      (failure) => emit(
        state.copyWith(
          productsStatus: ViewAllProductsStatus.failure,
          error: failure.message,
        ),
      ),
      (products) => emit(
        state.copyWith(
          products: products,
          productsStatus: ViewAllProductsStatus.success,
        ),
      ),
    );
  }

  FutureOr<void> _refreshProducts(
      RefreshProductsEvent event, Emitter<ViewAllProductsState> emit) async {
    emit(state.copyWith(productsStatus: ViewAllProductsStatus.loading));

    final Either<Failure, List<Product>> productsResult =
        await getProductsInSubCategoryUseCase(
      event.subCategory,
    );

    productsResult.fold(
      (failure) => emit(
        state.copyWith(
          productsStatus: ViewAllProductsStatus.failure,
          error: failure.message,
        ),
      ),
      (products) => emit(
        state.copyWith(
          products: products,
          productsStatus: ViewAllProductsStatus.success,
        ),
      ),
    );
  }

  FutureOr<void> _loadMoreCategories(
      LoadMoreCategoriesEvent event, Emitter<ViewAllProductsState> emit) async {
    emit(
      state.copyWith(
        categoriesStatus: ViewAllProductsStatus.loading,
      ),
    );

    final List<Category> oldCategories = state.categories;

    final Either<Failure, List<Category>> categoriesResult =
        await getCategoriesUseCase(state.categories.last);

    categoriesResult.fold(
      (failure) => emit(
        state.copyWith(
          categoriesStatus: ViewAllProductsStatus.failure,
          error: failure.message,
        ),
      ),
      (categories) => emit(
        state.copyWith(
          categories: [...oldCategories, ...categories],
          categoriesStatus: ViewAllProductsStatus.success,
        ),
      ),
    );
  }

  FutureOr<void> _loadMoreSubCategories(LoadMoreSubCategoriesEvent event,
      Emitter<ViewAllProductsState> emit) async {
    emit(
      state.copyWith(
        subCategoriesStatus: ViewAllProductsStatus.loading,
      ),
    );

    final List<SubCategory> oldSubCategories = state.subCategories;

    final Either<Failure, List<SubCategory>> subCategoriesResult =
        await getSubCategoriesInCategoryUseCase(
            event.category, state.subCategories.last);

    subCategoriesResult.fold(
      (failure) => emit(
        state.copyWith(
          subCategoriesStatus: ViewAllProductsStatus.failure,
          error: failure.message,
        ),
      ),
      (subCategories) => emit(
        state.copyWith(
          subCategories: [...oldSubCategories, ...subCategories],
          subCategoriesStatus: ViewAllProductsStatus.success,
        ),
      ),
    );
  }

  FutureOr<void> _loadMoreProducts(
      LoadMoreProductsEvent event, Emitter<ViewAllProductsState> emit) async {
    emit(
      state.copyWith(
        productsStatus: ViewAllProductsStatus.loading,
      ),
    );

    final List<Product> oldProducts = state.products;

    final Either<Failure, List<Product>> productsResult =
        await getProductsInSubCategoryUseCase(
      event.subCategory,
      state.products.last,
    );

    productsResult.fold(
      (failure) => emit(
        state.copyWith(
          productsStatus: ViewAllProductsStatus.failure,
          error: failure.message,
        ),
      ),
      (products) => emit(
        state.copyWith(
          products: [...oldProducts, ...products],
          productsStatus: ViewAllProductsStatus.success,
        ),
      ),
    );
  }
}
