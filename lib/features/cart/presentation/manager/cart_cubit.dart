import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/cart/domain/entities/get_cart_entity.dart';
import 'package:flower_app/features/cart/domain/use_case/get_cart_use_case.dart';
import 'package:flower_app/features/cart/domain/use_case/remove_cart_use_case.dart';
import 'package:flower_app/features/cart/presentation/manager/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/model/request/update_cart_request.dart';
import '../../domain/use_case/update_cart_use_case.dart';
import 'cart_event.dart';

@lazySingleton
class CartCubit extends Cubit<CartState> {
  final GetCartUseCase _getCartUseCase;
  final RemoveCartUseCase _removeCartUseCase;
  final UpdateCartUseCase _updateCartUseCase;

  CartCubit(
    this._getCartUseCase,
    this._removeCartUseCase,
    this._updateCartUseCase,
  ) : super(const CartState());

  void doEvent(CartEvent event) {
    switch (event) {
      case GetCartItemsEvent():
        _getCartItems();

      case UpdateCartItemEvent():
        _updateCartItem(event.quantity, event.productId);

      case DeleteCartItemEvent():
        _deleteCartItem(event.productId);
    }
  }

  ////? Get All Cart
  Future<void> _getCartItems() async {
    emit(
      state.copyWith(
        getCartItemsStateParam: state.getCartItemsState.copyWith(
          isLoadingParam: true,
        ),
      ),
    );

    final response = await _getCartUseCase.call();

    switch (response) {
      case Success<GetCartEntity>():
        emit(
          state.copyWith(
            getCartItemsStateParam: state.getCartItemsState.copyWith(
              isLoadingParam: false,
              isSuccessParam: true,
              dataParam: response.data,
            ),
          ),
        );

      case Failure<GetCartEntity>():
        emit(
          state.copyWith(
            getCartItemsStateParam: state.getCartItemsState.copyWith(
              isLoadingParam: false,
              isSuccessParam: false,
              errorMessageParam: response.errorMessage,
            ),
          ),
        );
    }
  }

  /////? Remove To Cart
  Future<void> _deleteCartItem(String id) async {
    emit(
      state.copyWith(
        deleteCartItemStateParam: state.deleteCartItemState.copyWith(
          isLoadingParam: true,
        ),
      ),
    );

    final response = await _removeCartUseCase.call(id);

    switch (response) {
      case Success<GetCartEntity>():
        emit(
          state.copyWith(
            deleteCartItemStateParam: state.deleteCartItemState.copyWith(
              isLoadingParam: false,
              isSuccessParam: true,
              dataParam: response.data,
            ),

            getCartItemsStateParam: state.getCartItemsState.copyWith(
              dataParam: response.data,
            ),
          ),
        );

      case Failure<GetCartEntity>():
        emit(
          state.copyWith(
            deleteCartItemStateParam: state.deleteCartItemState.copyWith(
              isLoadingParam: false,
              isSuccessParam: false,
              errorMessageParam: response.errorMessage,
            ),
          ),
        );
    }
  }

  /////? Update to cart ( Add, Remove )
  Future<void> _updateCartItem(UpdateCartRequest quantity, String id) async {
    emit(
      state.copyWith(
        updateCartItemStateParam: state.updateCartItemState.copyWith(
          isLoadingParam: true,
        ),
      ),
    );

    final response = await _updateCartUseCase.call(quantity, id);

    switch (response) {
      case Success<GetCartEntity>():
        emit(
          state.copyWith(
            updateCartItemStateParam: state.updateCartItemState.copyWith(
              isLoadingParam: false,
              isSuccessParam: true,
              dataParam: response.data,
            ),

            getCartItemsStateParam: state.getCartItemsState.copyWith(
              dataParam: response.data,
            ),
          ),
        );

      case Failure<GetCartEntity>():
        emit(
          state.copyWith(
            updateCartItemStateParam: state.updateCartItemState.copyWith(
              isLoadingParam: false,
              isSuccessParam: false,
              errorMessageParam: response.errorMessage,
            ),
          ),
        );
    }
  }
}
