import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/cart/domain/entities/get_cart_entity.dart';
import 'package:flower_app/features/cart/domain/use_case/get_cart_use_case.dart';
import 'package:flower_app/features/cart/domain/use_case/remove_cart_use_case.dart';
import 'package:flower_app/features/cart/presentation/manager/cart_state.dart';
import 'package:injectable/injectable.dart';
import '../../data/model/request/update_cart_request.dart';
import '../../domain/use_case/update_cart_use_case.dart';
import 'cart_event.dart';

@injectable
class CartCubit extends Cubit<CartState> {
  final GetCartUseCase _getCartUseCase;
  final RemoveCartUseCase _removeCartUseCase;
  final UpdateCartUseCase _updateCartUseCase;

  CartCubit(
    this._getCartUseCase,
    this._removeCartUseCase,
    this._updateCartUseCase,
  ) : super(const CartState());

  ////? Get All Cart
  Future<void> _getCart() async {
    emit(state.copyWith(getCart: state.getCart.copyWith(isLoadingParam: true)));

    final response = await _getCartUseCase.call();

    switch (response) {
      case Success<GetCartEntity>():
        emit(
          state.copyWith(
            getCart: state.getCart.copyWith(
              isLoadingParam: false,
              dataParam: response.data,
              isSuccessParam: true,
            ),
          ),
        );

      case Failure<GetCartEntity>():
        emit(
          state.copyWith(
            getCart: state.getCart.copyWith(
              isLoadingParam: false,
              errorMessageParam: response.errorMessage,
              isSuccessParam: false,
            ),
          ),
        );
    }
  }

  /////? Remove To Cart
  Future<void> _removeToCart(String id) async {
    emit(
      state.copyWith(
        removeFromCartSuccess: state.removeFromCartSuccess.copyWith(
          isLoadingParam: true,
        ),
      ),
    );
    final response = await _removeCartUseCase.call(id);
    switch (response) {
      case Success<GetCartEntity>():
        {
          emit(
            state.copyWith(
              removeFromCartSuccess: state.removeFromCartSuccess.copyWith(
                isLoadingParam: false,
                dataParam: response.data,
                isSuccessParam: true,
              ),
            ),
          );
          doEvent(GetAllCartEvent());
        }

      case Failure<GetCartEntity>():
        emit(
          state.copyWith(
            removeFromCartSuccess: state.removeFromCartSuccess.copyWith(
              isLoadingParam: false,
              errorMessageParam: response.errorMessage,
              isSuccessParam: false,
            ),
          ),
        );
    }
  }

  /////? Update to cart ( Add, Remove )
  Future<void> _updateCart(UpdateCartRequest quantity, String id) async {
    emit(
      state.copyWith(
        updateCartSuccess: state.updateCartSuccess.copyWith(
          isLoadingParam: true,
        ),
      ),
    );
    final response = await _updateCartUseCase.call(quantity, id);
    switch (response) {
      case Success<GetCartEntity>():
        {
          emit(
            state.copyWith(
              updateCartSuccess: state.updateCartSuccess.copyWith(
                isLoadingParam: false,
                dataParam: response.data,
                isSuccessParam: true,
              ),
            ),
          );
          doEvent(GetAllCartEvent());
        }

      case Failure<GetCartEntity>():
        emit(
          state.copyWith(
            updateCartSuccess: state.updateCartSuccess.copyWith(
              isLoadingParam: false,
              errorMessageParam: response.errorMessage,
              isSuccessParam: false,
            ),
          ),
        );
    }
  }

  void doEvent(CartEvent event) {
    switch (event) {
      case GetAllCartEvent():
        _getCart();
        break;
      case RemoveToCart():
        _removeToCart(event.id);
        break;
      case UpdateCart():
        _updateCart(event.quantity, event.id);
        break;
    }
  }
}
