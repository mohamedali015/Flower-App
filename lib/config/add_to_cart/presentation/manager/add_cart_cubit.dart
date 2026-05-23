import 'package:flower_app/config/add_to_cart/presentation/manager/add_cart_state.dart';
import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/cart/domain/entities/get_cart_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../features/cart/data/model/request/add_to_cart_request.dart';
import '../../domain/use_case/add_cart_use_case.dart';
import 'add_cart_event.dart';

@injectable
class AddCartCubit extends Cubit<AddCartState> {
  final AddCartUseCase _addCartUseCase;

  AddCartCubit(this._addCartUseCase) : super(const AddCartState());

  ////? Add To Cart
  Future<void> _addToCart(AddToCartRequest request) async {
    emit(
      state.copyWith(
        addToCartSuccess: state.addToCartSuccess.copyWith(isLoadingParam: true),
      ),
    );
    final response = await _addCartUseCase.call(request);
    switch (response) {
      case Success<GetCartEntity>():
        {
          emit(
            state.copyWith(
              addToCartSuccess: state.addToCartSuccess.copyWith(
                isLoadingParam: false,
                dataParam: response.data,
                isSuccessParam: true,
              ),
            ),
          );
        }

      case Failure<GetCartEntity>():
        emit(
          state.copyWith(
            addToCartSuccess: state.addToCartSuccess.copyWith(
              isLoadingParam: false,
              errorMessageParam: response.errorMessage,
              isSuccessParam: false,
            ),
          ),
        );
    }
  }

  void doEvent(AddCartEvent event) {
    switch (event) {
      case AddToCart():
        _addToCart(event.addToCartRequest);
        break;
    }
  }
}
