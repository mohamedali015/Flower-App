import 'package:equatable/equatable.dart';
import 'package:flower_app/features/cart/domain/entities/get_cart_entity.dart';

import '../../../../config/base_state/base_state.dart';

class AddCartState extends Equatable {

  final BaseState<GetCartEntity> addToCartSuccess;

  const AddCartState({
    this.addToCartSuccess = const BaseState(),
});

  AddCartState copyWith({
    BaseState<GetCartEntity>? getCart,
    BaseState<GetCartEntity>? addToCartSuccess,
    BaseState<GetCartEntity>? removeFromCartSuccess,
    BaseState<GetCartEntity>? updateCartSuccess,
  }) {
    return AddCartState(
      addToCartSuccess: addToCartSuccess ?? this.addToCartSuccess,
    );
  }

  @override
  List<Object?> get props => [
    addToCartSuccess,
  ];
}
