import 'package:equatable/equatable.dart';
import 'package:flower_app/features/cart/domain/entities/get_cart_entity.dart';

import '../../../../config/base_state/base_state.dart';

class CartState extends Equatable {
  final BaseState<GetCartEntity> getCartItemsState;
  final BaseState<GetCartEntity> updateCartItemState;
  final BaseState<GetCartEntity> deleteCartItemState;

  const CartState({
    this.getCartItemsState = const BaseState(),
    this.updateCartItemState = const BaseState(),
    this.deleteCartItemState = const BaseState(),
  });

  CartState copyWith({
    BaseState<GetCartEntity>? getCartItemsStateParam,
    BaseState<GetCartEntity>? updateCartItemStateParam,
    BaseState<GetCartEntity>? deleteCartItemStateParam,
  }) {
    return CartState(
      getCartItemsState: getCartItemsStateParam ?? getCartItemsState,

      updateCartItemState: updateCartItemStateParam ?? updateCartItemState,

      deleteCartItemState: deleteCartItemStateParam ?? deleteCartItemState,
    );
  }

  @override
  List<Object?> get props => [
    getCartItemsState,
    updateCartItemState,
    deleteCartItemState,
  ];
}
