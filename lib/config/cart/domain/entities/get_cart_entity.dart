import 'package:equatable/equatable.dart';
import 'cart_item_entity.dart';

class GetCartEntity extends Equatable {
  final int? numOfCartItems;
  final num? totalPrice;
  final num? totalPriceAfterDiscount;
  final List<CartItemEntity> cartItems;

  const GetCartEntity({
    required this.numOfCartItems,
    required this.totalPrice,
    required this.totalPriceAfterDiscount,
    required this.cartItems,
  });

  @override
  List<Object?> get props => [
    numOfCartItems,
    totalPrice,
    totalPriceAfterDiscount,
    cartItems,
  ];
}
