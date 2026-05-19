import 'package:flower_app/config/products/data/params/product_query_params.dart';
import 'package:flower_app/config/products/domain/use_case/get_products_use_case.dart';
import 'package:flower_app/features/occasions/domain/use_case/get_occasions_use_case.dart';
import 'package:flower_app/features/occasions/presentation/manager/occasions_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/error_handling/result.dart';
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
      params: ProductQueryParams(occasionId: event.occasionId),
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
}
