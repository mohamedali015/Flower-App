import 'package:flower_app/config/products/data/mapper/product_mapper.dart';
import 'package:flower_app/features/orders/data/models/order_items.dart';
import 'package:flower_app/features/orders/domain/entities/order_item_entity.dart';

extension OrderItemsMapper on OrderItems {
  OrderItemEntity toEntity() {
    return OrderItemEntity(
      product: product?.toEntity(),
      price: price,
      quantity: quantity,
    );
  }
}
