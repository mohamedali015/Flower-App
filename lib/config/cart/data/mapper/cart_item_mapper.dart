import '../../../cart/data/mapper/product_mapper.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../model/response/cart_item_response.dart';

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
