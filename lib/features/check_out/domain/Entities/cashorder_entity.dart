import 'package:equatable/equatable.dart';
import 'package:flower_app/config/products/domain/entities/product_entity.dart';

class CashOrderEntity extends Equatable {
  final String? message;
  final OrderEntity? order;

  const CashOrderEntity({this.message, this.order});

  @override
  List<Object?> get props => [message, order];
}

class OrderEntity extends Equatable {
  final String? user;
  final List<OrderItemEntity>? orderItems;
  final int? totalPrice;
  final String? paymentType;
  final bool? isPaid;
  final bool? isDelivered;
  final String? state;
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? orderNumber;

  const OrderEntity({
    this.user,
    this.orderItems,
    this.totalPrice,
    this.paymentType,
    this.isPaid,
    this.isDelivered,
    this.state,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.orderNumber,
  });

  @override
  List<Object?> get props => [
        user,
        orderItems,
        totalPrice,
        paymentType,
        isPaid,
        isDelivered,
        state,
        id,
        createdAt,
        updatedAt,
        orderNumber,
      ];
}

class OrderItemEntity extends Equatable {
  final ProductEntity? product;
  final int? price;
  final int? quantity;
  final String? id;

  const OrderItemEntity({this.product, this.price, this.quantity, this.id});

  @override
  List<Object?> get props => [product, price, quantity, id];
}
