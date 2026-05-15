import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/error_handling/result.dart';
import '../../../../config/products/data/params/product_query_params.dart';
import '../../../../config/products/domain/use_case/get_products_use_case.dart';
import 'best_seller_event.dart';
import 'best_seller_state.dart';

@injectable
class BestSellerCubit extends Cubit<BestSellerState> {
  final GetProductsUseCase _getProductsUseCase;

  BestSellerCubit(this._getProductsUseCase) : super(const BestSellerState());
  void doEvent(BestSellerEvents event) {
    switch (event) {
      case GetBestSellerEvent():
        _getBestSellerProducts();
    }
  }

  Future<void> _getBestSellerProducts() async {
    emit(
      state.copyWith(
        bestSellerStateParam: state.bestSellerState.copyWith(
          isLoadingParam: true,
        ),
      ),
    );

    final result = await _getProductsUseCase.call(params: ProductQueryParams());

    switch (result) {
      case Success():
        emit(
          state.copyWith(
            bestSellerStateParam: state.bestSellerState.copyWith(
              isLoadingParam: false,
              isSuccessParam: true,
              dataParam: result.data,
            ),
          ),
        );

      case Failure():
        emit(
          state.copyWith(
            bestSellerStateParam: state.bestSellerState.copyWith(
              isLoadingParam: false,
              isSuccessParam: false,
              errorMessageParam: result.errorMessage,
            ),
          ),
        );
    }
  }
}
