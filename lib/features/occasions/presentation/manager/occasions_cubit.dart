import 'package:flower_app/config/products/data/params/product_query_params.dart';
import 'package:flower_app/config/products/domain/use_case/get_products_use_case.dart';
import 'package:flower_app/features/occasions/domain/use_case/get_occasions_use_case.dart';
import 'package:flower_app/features/occasions/presentation/manager/occasions_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/error_handling/result.dart';
import '../../../../config/products/domain/entities/products_response_entity.dart';
import 'occasions_state.dart';

@injectable
class OccasionsCubit extends Cubit<OccasionsState> {
  OccasionsCubit(this._getProductsUseCase, this._getOccasionsUseCase)
    : super(const OccasionsState());

  final GetOccasionsUseCase _getOccasionsUseCase;
  final GetProductsUseCase _getProductsUseCase;

  void doEvent(OccasionsEvents event) {
    switch (event) {
      case GetOccasionsCategoriesEvent():
        _getOccasionsCategories();

      case GetOccasionProductsEvent():
        _getOccasionProducts(event);

      case LoadMoreOccasionProductsEvent():
        _loadMoreOccasionProducts(event);
    }
  }

  Future<void> _getOccasionsCategories() async {
    emit(
      state.copyWith(
        occasionsCategoryStateParam: state.occasionsCategoryState.copyWith(
          isLoadingParam: true,
        ),
      ),
    );

    final result = await _getOccasionsUseCase.call();

    switch (result) {
      case Success():
        emit(
          state.copyWith(
            occasionsCategoryStateParam: state.occasionsCategoryState.copyWith(
              isLoadingParam: false,
              isSuccessParam: true,
              dataParam: result.data,
            ),
          ),
        );

      case Failure():
        emit(
          state.copyWith(
            occasionsCategoryStateParam: state.occasionsCategoryState.copyWith(
              isLoadingParam: false,
              isSuccessParam: false,
              errorMessageParam: result.errorMessage,
            ),
          ),
        );
    }
  }

  Future<void> _getOccasionProducts(GetOccasionProductsEvent event) async {
    emit(
      state.copyWith(
        occasionProductsStateParam: state.occasionProductsState.copyWith(
          isLoadingParam: true,
        ),
      ),
    );

    final result = await _getProductsUseCase.call(
      params: ProductQueryParams(
        occasionId: event.occasionId,
        page: 1,
        limit: 10,
      ),
    );

    switch (result) {
      case Success():
        emit(
          state.copyWith(
            occasionProductsStateParam: state.occasionProductsState.copyWith(
              isLoadingParam: false,
              isSuccessParam: true,
              dataParam: result.data,
            ),
          ),
        );

      case Failure():
        emit(
          state.copyWith(
            occasionProductsStateParam: state.occasionProductsState.copyWith(
              isLoadingParam: false,
              isSuccessParam: false,
              errorMessageParam: result.errorMessage,
            ),
          ),
        );
    }
  }

  Future<void> _loadMoreOccasionProducts(
    LoadMoreOccasionProductsEvent event,
  ) async {
    if (state.isFetchingMore) return;

    final currentData = state.occasionProductsState.data;
    if (currentData == null) return;

    final currentPage = currentData.metadata.currentPage;
    final totalPages = currentData.metadata.totalPages;

    if (currentPage >= totalPages) return;

    emit(state.copyWith(isFetchingMoreParam: true));

    final result = await _getProductsUseCase.call(
      params: ProductQueryParams(
        occasionId: event.occasionId,
        page: (currentPage + 1).toInt(),
        limit: 10,
      ),
    );

    switch (result) {
      case Success():
        final newProducts = result.data.products;

        final updatedData = ProductsResponseEntity(
          products: [...currentData.products, ...newProducts],
          metadata: result.data.metadata,
        );

        emit(
          state.copyWith(
            isFetchingMoreParam: false,
            occasionProductsStateParam: state.occasionProductsState.copyWith(
              dataParam: updatedData,
            ),
          ),
        );

      case Failure():
        emit(state.copyWith(isFetchingMoreParam: false));
    }
  }
}
