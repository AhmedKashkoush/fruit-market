import 'dart:async';

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

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetSubCategoriesInCategoryUseCase getSubCategoriesInCategoryUseCase;
  final GetProductsInSubCategoryUseCase getProductsInSubCategoryUseCase;
  HomeBloc(
    this.getCategoriesUseCase,
    this.getSubCategoriesInCategoryUseCase,
    this.getProductsInSubCategoryUseCase,
  ) : super(
          const HomeState(
            categories: [],
            productsInSubCategories: [],
            status: HomeStatus.initial,
          ),
        ) {
    on<GetCategoriesEvent>(_getCategories);
    on<GetProductsEvent>(_getProductsInCategory);
  }

  FutureOr<void> _getCategories(
      GetCategoriesEvent event, Emitter<HomeState> emit) async {
    final HomeState oldState = state;
    emit(state.copyWith(status: HomeStatus.loading));
    final Either<Failure, List<Category>> result = await getCategoriesUseCase();
    result.fold(
      (failure) => state.copyWith(
        categories: oldState.categories,
        productsInSubCategories: oldState.productsInSubCategories,
        status: HomeStatus.failure,
        error: failure.message,
      ),
      (categories) => state.copyWith(
        categories: [...oldState.categories, ...categories],
        productsInSubCategories: oldState.productsInSubCategories,
      ),
    );
    emit(state);
    add(GetProductsEvent(state.categories.first));
  }

  FutureOr<void> _getProductsInCategory(
      GetProductsEvent event, Emitter<HomeState> emit) async {
    final HomeState oldState = state;
    final Either<Failure, List<SubCategory>> subCategoryResult =
        await getSubCategoriesInCategoryUseCase(
            event.category, oldState.productsInSubCategories.last.keys.first);
    subCategoryResult.fold(
        (failure) => state.copyWith(
              categories: oldState.categories,
              productsInSubCategories: oldState.productsInSubCategories,
              status: HomeStatus.failure,
              error: failure.message,
            ), (subCategories) async {
      List<Map<SubCategory, List<Product>>> productsInSubCategories = [];
      for (var subCategory in subCategories) {
        final Either<Failure, List<Product>> productResult =
            await getProductsInSubCategoryUseCase(
          subCategory,
          oldState
              .productsInSubCategories[subCategories.indexOf(subCategory)]
                  [subCategory]
              ?.last,
        );
        productResult.fold(
          (failure) => state.copyWith(
            categories: oldState.categories,
            productsInSubCategories: oldState.productsInSubCategories,
            status: HomeStatus.failure,
            error: failure.message,
          ),
          (products) => productsInSubCategories.add({subCategory: products}),
        );
      }
      if (state.status == HomeStatus.success) {
        state.copyWith(
          categories: oldState.categories,
          productsInSubCategories: productsInSubCategories,
        );
      }
    });

    return emit(state);
  }
}
