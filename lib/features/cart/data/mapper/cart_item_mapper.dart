import 'package:flower_app/features/cart/data/mapper/product_mapper.dart';
import 'package:flower_app/features/cart/data/model/response/cart_item_response.dart';
import 'package:flower_app/features/cart/domain/entities/cart_item_entity.dart';

extension CartItemMapper on CartItems {
  CartItemEntity toEntity() {
    return CartItemEntity(
      id: id,
      price: price,
      quantity: quantity,
      productEntity: product!.toEntity(),
    );
  }
}
