import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';


import '../../../../config/error_handling/result.dart';
import '../../../../config/products/data/params/product_query_params.dart';
import '../../../../config/products/domain/use_case/get_products_use_case.dart';
import '../../domain/use_case/get_category_use_case.dart';
import 'category_event.dart';
import 'category_state.dart';

@injectable
class CategoryCubit extends Cubit<CategoryState> {
  final GetCategoryUseCase _getCategoryUseCase;
  final GetProductsUseCase _getProductsUseCase;

  CategoryCubit(this._getCategoryUseCase, this._getProductsUseCase)
    : super(const CategoryState());

  Future<void> _getAllCategories() async {
    emit(
      state.copyWith(
        categoriesStateParam: state.categoriesState.copyWith(
          isLoadingParam: true,
        ),
      ),
    );

    final result = await _getCategoryUseCase.getAllCategories();

    switch (result) {
      case Success():
        emit(
          state.copyWith(
            categoriesStateParam: state.categoriesState.copyWith(
              isLoadingParam: false,
              isSuccessParam: true,
              dataParam: result.data,
            ),
          ),
        );

      case Failure():
        emit(
          state.copyWith(
            categoriesStateParam: state.categoriesState.copyWith(
              isLoadingParam: false,
              isSuccessParam: false,
              errorMessageParam: result.errorMessage,
            ),
          ),
        );
    }
  }

  Future<void> _getProducts(ProductQueryParams params) async {
    emit(
      state.copyWith(
        productsStateParam: state.productsState.copyWith(
          isLoadingParam: true,
        ),
        selectedCategoryId: params.categoryId,
        selectedSortOption: params.sort,
      ),
    );

    final result = await _getProductsUseCase.call(params: params);

    switch (result) {
      case Success():
        emit(
          state.copyWith(
            productsStateParam: state.productsState.copyWith(
              isLoadingParam: false,
              isSuccessParam: true,
              dataParam: result.data.products,
            ),
          ),
        );

      case Failure():
        emit(
          state.copyWith(
            productsStateParam: state.productsState.copyWith(
              isLoadingParam: false,
              isSuccessParam: false,
              errorMessageParam: result.errorMessage,
            ),
          ),
        );
    }
  }

  void doEvent(CategoryEvent event) {
    switch (event) {
      case GetAllCategoryEvent():
        _getAllCategories();
        break;

      case ProductEvent():
        _getProducts(event.categoryId);
        break;
    }
  }
}
