import 'package:flower_app/config/products/domain/entities/product_entity.dart';

class OrderItemEntity {
  final ProductEntity? product;
  final int? price;
  final int? quantity;

  OrderItemEntity({this.product, this.price, this.quantity});
}
