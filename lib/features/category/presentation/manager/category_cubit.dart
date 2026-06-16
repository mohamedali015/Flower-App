import 'package:flower_app/config/products/domain/entities/product_entity.dart';
import 'package:flower_app/config/products/domain/entities/products_response_entity.dart';
import 'package:flower_app/features/filter/domain/enums/sort_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../config/error_handling/result.dart';
import '../../../../config/products/data/params/product_query_params.dart';
import '../../../../config/products/domain/use_case/get_products_use_case.dart';
import '../../domain/entities/get_all_category_entity.dart';
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
    emit(state.copyWith(isLoading: true, clearCategoryError: true));

    final response = await _getCategoryUseCase.getAllCategories();

    switch (response) {
      case Success<List<GetAllCategoryEntity>>():
        emit(
          state.copyWith(
            categories: response.data,
            isLoading: false,
            clearCategoryError: true,
          ),
        );

      case Failure<List<GetAllCategoryEntity>>():
        emit(
          state.copyWith(isLoading: false, errorMessage: response.errorMessage),
        );
    }
  }

  Future<void> _getProducts(ProductQueryParams params) async {
    emit(
      state.copyWith(
        isProductLoading: true,
        clearProductError: true,
        selectedCategoryId: params.categoryId,
        selectedSortOption: params.sort,
      ),
    );

    final response = await _getProductsUseCase.call(
      params: ProductQueryParams(
        categoryId: params.categoryId,
        sort: params.sort,
      ),
    );

    switch (response) {
      case Success<ProductsResponseEntity>():
        final List<ProductEntity> sortedProducts = List<ProductEntity>.from(
          response.data.products,
        );

        if (params.sort == SortOption.lowestPrice) {
          sortedProducts.sort(
            (a, b) => a.priceAfterDiscount.compareTo(b.priceAfterDiscount),
          );
        } else if (params.sort == SortOption.highestPrice) {
          sortedProducts.sort(
            (a, b) => b.priceAfterDiscount.compareTo(a.priceAfterDiscount),
          );
        } else if (params.sort == SortOption.discount) {
          sortedProducts.sort((a, b) => b.discount.compareTo(a.discount));
        }

        emit(state.copyWith(products: sortedProducts, isProductLoading: false));

      case Failure<ProductsResponseEntity>():
        emit(
          state.copyWith(
            isProductLoading: false,
            clearProductError: true,
            productErrorMessage: response.errorMessage,
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
