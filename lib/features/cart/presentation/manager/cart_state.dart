import 'package:equatable/equatable.dart';
import 'package:flower_app/features/cart/domain/entities/get_cart_entity.dart';

import '../../../../config/base_state/base_state.dart';

class CartState extends Equatable {
  final BaseState<GetCartEntity> getCart;
  final BaseState<GetCartEntity> addToCartSuccess;
  final BaseState<GetCartEntity> removeFromCartSuccess;
  final BaseState<GetCartEntity> updateCartSuccess;

  const CartState({
    this.getCart = const BaseState(),
    this.addToCartSuccess = const BaseState(),
    this.removeFromCartSuccess = const BaseState(),
    this.updateCartSuccess = const BaseState(),
  });

  CartState copyWith({
    BaseState<GetCartEntity>? getCart,
    BaseState<GetCartEntity>? addToCartSuccess,
    BaseState<GetCartEntity>? removeFromCartSuccess,
    BaseState<GetCartEntity>? updateCartSuccess,
  }) {
    return CartState(
      getCart: getCart ?? this.getCart,
      addToCartSuccess: addToCartSuccess ?? this.addToCartSuccess,
      removeFromCartSuccess:
          removeFromCartSuccess ?? this.removeFromCartSuccess,
      updateCartSuccess: updateCartSuccess ?? this.updateCartSuccess,
    );
  }

  @override
  List<Object?> get props => [
    getCart,
    addToCartSuccess,
    removeFromCartSuccess,
    updateCartSuccess,
  ];
}
