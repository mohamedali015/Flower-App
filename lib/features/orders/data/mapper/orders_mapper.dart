import 'package:flower_app/features/orders/data/mapper/order_items_mapper.dart';
import 'package:flower_app/features/orders/data/models/orders.dart';
import 'package:flower_app/features/orders/domain/entities/orders_entity.dart';

extension OrdersMapper on Orders {
  OrdersEntity toEntity() {
    return OrdersEntity(
      id: Id,
      user: user,
      orderItems: orderItems?.map((e) => e.toEntity()).toList(),
      totalPrice: totalPrice,
      paymentType: paymentType,
      isPaid: isPaid,
      isDelivered: isDelivered,
      state: state,
      createdAt: createdAt,
      updatedAt: updatedAt,
      orderNumber: orderNumber,
    );
  }
}
