import 'package:equatable/equatable.dart';
import 'package:flower_app/features/cart/domain/entities/product_cart_entity.dart';

class CartItemEntity extends Equatable {
  final String? id;
  final num? price;
  final int? quantity;
  final ProductCartEntity productEntity;

  const CartItemEntity({
    required this.id,
    required this.price,
    required this.quantity,
    required this.productEntity,
  });

  @override
  List<Object?> get props => [id, price, quantity, productEntity];
}
