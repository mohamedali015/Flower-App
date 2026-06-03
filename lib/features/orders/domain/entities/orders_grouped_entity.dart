import 'package:equatable/equatable.dart';
import 'package:flower_app/config/products/domain/entities/metadata_entity.dart';
import 'package:flower_app/features/orders/domain/entities/orders_entity.dart';

class OrdersGroupedEntity extends Equatable {
  final List<OrdersEntity> active;
  final List<OrdersEntity> delivered;
  final MetadataEntity metadata;

  OrdersGroupedEntity({
    required this.active,
    required this.delivered,
    required this.metadata,
  });

  @override
  List<Object?> get props => [active, delivered, metadata];
}
