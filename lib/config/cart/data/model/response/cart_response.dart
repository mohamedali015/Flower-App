import 'package:json_annotation/json_annotation.dart';
import 'get_cart_response.dart';
part 'cart_response.g.dart';

@JsonSerializable()
class CartResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "numOfCartItems")
  final int? numOfCartItems;
  @JsonKey(name: "cart")
  final Cart? cart;

  CartResponse({this.message, this.numOfCartItems, this.cart});

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return _$CartResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CartResponseToJson(this);
  }
}
