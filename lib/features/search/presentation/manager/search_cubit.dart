import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/error_handling/result.dart';
import '../../../../config/products/data/params/product_query_params.dart';
import '../../../../config/products/domain/use_case/get_products_use_case.dart';
import 'search_event.dart';
import 'search_state.dart';

@injectable
class SearchCubit extends Cubit<SearchState> {
  final GetProductsUseCase _getProductsUseCase;
  Timer? _debounce;

  SearchCubit(this._getProductsUseCase) : super(const SearchState());

  void getSearchEvent(SearchEvent event) {
    switch (event) {
      case SearchProductEvent():
        _handleSearch(event.search);
        break;
    }
  }

  void _handleSearch(ProductQueryParams query) {
    _debounce?.cancel();

    final searchText = (query.search ?? '').trim();

    if (searchText.isEmpty) {
      emit(
        state.copyWith(
          searchProducts: [],
          isSearchProductLoading: false,
          clearError: true, // ✅ Fix 2
        ),
      );
      return;
    }

    _debounce = Timer(
      const Duration(milliseconds: 500),
          () => _search(query),
    );
  }

  Future<void> _search(ProductQueryParams query) async {
    emit(
      state.copyWith(
        isSearchProductLoading: true,
        clearError: true, // ✅ Fix 2: بدل searchProductErrorMessage: null
      ),
    );

    final response = await _getProductsUseCase(params: query);

    switch (response) {
      case Success():
        emit(
          state.copyWith(
            searchProducts: response.data.products,
            isSearchProductLoading: false,
            clearError: true,
          ),
        );
        break;

      case Failure():
        emit(
          state.copyWith(
            isSearchProductLoading: false,
            searchProductErrorMessage: response.errorMessage,
          ),
        );
        break;
    }
  }

  void clearSearch() {
    _debounce?.cancel();
    emit(
      state.copyWith(
        searchProducts: [],
        isSearchProductLoading: false,
        clearError: true,
      ),
    );
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}