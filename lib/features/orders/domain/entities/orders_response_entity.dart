import 'package:flower_app/config/products/domain/entities/metadata_entity.dart';
import 'package:flower_app/features/orders/domain/entities/orders_entity.dart';

class OrdersResponseEntity {
  final List<OrdersEntity> orders;
  final MetadataEntity metadata;

  OrdersResponseEntity({required this.orders, required this.metadata});
}
