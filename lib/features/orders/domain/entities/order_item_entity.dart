import 'package:equatable/equatable.dart';
import 'package:flower_app/config/products/domain/entities/product_entity.dart';

class OrderItemEntity extends Equatable {
  final ProductEntity? product;
  final int? price;
  final int? quantity;

  const OrderItemEntity({this.product, this.price, this.quantity});

  @override
  List<Object?> get props => [product, price, quantity];
}
