import 'package:flower_app/features/cart/data/model/response/cart_response.dart';
import '../../domain/entities/get_cart_entity.dart';
import 'cart_item_mapper.dart';

extension CarMapper on CartResponse {
  GetCartEntity toEntity() {
    return GetCartEntity(
      numOfCartItems: numOfCartItems,
      totalPrice: cart?.totalPrice,
      totalPriceAfterDiscount: cart?.totalPriceAfterDiscount,
      cartItems: cart!.cartItems!.map((e) => e.toEntity()).toList(),
    );
  }
}
