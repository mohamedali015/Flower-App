import 'package:flower_app/config/cart/domain/use_case/add_cart_use_case.dart';
import 'package:flower_app/config/cart/domain/use_case/remove_all_cart_use_case.dart';
import 'package:flower_app/config/error_handling/result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../data/model/request/add_to_cart_request.dart';
import '../data/model/request/update_cart_request.dart';
import '../domain/entities/get_cart_entity.dart';
import '../domain/use_case/get_cart_use_case.dart';
import '../domain/use_case/remove_cart_use_case.dart';
import '../domain/use_case/update_cart_use_case.dart';
import 'cart_event.dart';
import 'cart_state.dart';

@injectable
class CartCubit extends Cubit<CartState> {
  final GetCartUseCase _getCartUseCase;
  final RemoveCartUseCase _removeCartUseCase;
  final UpdateCartUseCase _updateCartUseCase;
  final AddCartUseCase _addCartUseCase;
  final RemoveAllCartUseCase _removeAllCartUseCase;

  CartCubit(
    this._getCartUseCase,
    this._removeCartUseCase,
    this._updateCartUseCase,
    this._addCartUseCase,
    this._removeAllCartUseCase,
  ) : super(const CartState());

  void doEvent(CartEvent event) {
    switch (event) {
      /////? Get Cart Item
      case GetCartItemsEvent():
        _getCartItems();
        break;

      /////? Update Cart
      case UpdateCartItemEvent():
        _updateCartItem(event.quantity, event.productId);
        break;

      ////? Delete item
      case DeleteCartItemEvent():
        _deleteCartItem(event.productId);
        break;

      case AddToCart():
        _addToCart(event.addToCartRequest);
        break;
      case DeleteAll():
        _removeAllCart();
        break;
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

  //////? Add to cart
  Future<void> _addToCart(AddToCartRequest request) async {
    emit(
      state.copyWith(
        addToCartSuccessParam: state.addToCartSuccessState.copyWith(
          isLoadingParam: true,
        ),
      ),
    );
    final response = await _addCartUseCase.call(request);
    switch (response) {
      case Success<GetCartEntity>():
        emit(
          state.copyWith(
            addToCartSuccessParam: state.addToCartSuccessState.copyWith(
              isLoadingParam: false,
              dataParam: response.data,
              isSuccessParam: true,
            ),

            getCartItemsStateParam: state.getCartItemsState.copyWith(
              dataParam: response.data,
              isSuccessParam: true,
            ),
          ),
        );

      case Failure<GetCartEntity>():
        emit(
          state.copyWith(
            addToCartSuccessParam: state.addToCartSuccessState.copyWith(
              isLoadingParam: false,
              errorMessageParam: response.errorMessage,
              isSuccessParam: false,
            ),
          ),
        );
    }
  }

  /////? Delete All from Cart
  Future<void> _removeAllCart() async {
    emit(
      state.copyWith(
        deleteAllItemParam: state.deleteAllItemState.copyWith(
          isLoadingParam: true,
        ),
      ),
    );
    final response = await _removeAllCartUseCase.call();
    switch (response) {
      case Success<GetCartEntity>():
        emit(
          state.copyWith(
            deleteAllItemParam: state.deleteAllItemState.copyWith(
              isLoadingParam: false,
              dataParam: response.data,
              isSuccessParam: true,
            ),

            getCartItemsStateParam: state.getCartItemsState.copyWith(
              dataParam: response.data,
            ),
          ),
        );
      case Failure<GetCartEntity>():
        emit(
          state.copyWith(
            deleteAllItemParam: state.deleteAllItemState.copyWith(
              isLoadingParam: false,
              errorMessageParam: response.errorMessage,
              isSuccessParam: false,
            ),
          ),
        );
    }
  }

}


