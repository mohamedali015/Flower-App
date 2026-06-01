import 'package:flower_app/features/orders/domain/entities/orders_entity.dart';

class OrdersGroupedEntity {
  final List<OrdersEntity> pending;
  final List<OrdersEntity> delivered;

  OrdersGroupedEntity({required this.pending, required this.delivered});
}
