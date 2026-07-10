import 'package:equatable/equatable.dart';
import '../../../../config/base_state/base_state.dart';
import '../domain/entities/get_cart_entity.dart';

class CartState extends Equatable {
  final BaseState<GetCartEntity> getCartItemsState;
  final BaseState<GetCartEntity> updateCartItemState;
  final BaseState<GetCartEntity> deleteCartItemState;
  final BaseState<GetCartEntity> addToCartSuccessState;
  final BaseState<GetCartEntity> deleteAllItemState;

  const CartState({
    this.getCartItemsState = const BaseState(),
    this.updateCartItemState = const BaseState(),
    this.deleteCartItemState = const BaseState(),
    this.addToCartSuccessState = const BaseState(),
    this.deleteAllItemState = const BaseState(),
  });

  CartState copyWith({
    BaseState<GetCartEntity>? getCartItemsStateParam,
    BaseState<GetCartEntity>? updateCartItemStateParam,
    BaseState<GetCartEntity>? deleteCartItemStateParam,
    BaseState<GetCartEntity>? addToCartSuccessParam,
    BaseState<GetCartEntity>? deleteAllItemParam,
  }) {
    return CartState(
      getCartItemsState: getCartItemsStateParam ?? getCartItemsState,
      updateCartItemState: updateCartItemStateParam ?? updateCartItemState,
      deleteCartItemState: deleteCartItemStateParam ?? deleteCartItemState,
      addToCartSuccessState: addToCartSuccessParam ?? addToCartSuccessState,
      deleteAllItemState: deleteAllItemParam ?? deleteAllItemState,
    );
  }

  @override
  List<Object?> get props => [
    getCartItemsState,
    updateCartItemState,
    deleteCartItemState,
    addToCartSuccessState,
    deleteAllItemState,
  ];
}
