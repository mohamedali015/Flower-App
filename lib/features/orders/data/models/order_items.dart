import 'package:flower_app/config/products/data/model/response/product_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_items.g.dart';

@JsonSerializable()
class OrderItems {
  @JsonKey(name: "product")
  final ProductModel? product;
  @JsonKey(name: "price")
  final int? price;
  @JsonKey(name: "quantity")
  final int? quantity;
  @JsonKey(name: "_id")
  final String? Id;

  OrderItems({this.product, this.price, this.quantity, this.Id});

  factory OrderItems.fromJson(Map<String, dynamic> json) {
    return _$OrderItemsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OrderItemsToJson(this);
  }
}
