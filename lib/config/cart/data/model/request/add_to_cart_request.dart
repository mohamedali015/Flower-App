import 'package:json_annotation/json_annotation.dart';

part 'add_to_cart_request.g.dart';

@JsonSerializable()
class AddToCartRequest {
  @JsonKey(name: "product")
  final String? product;
  @JsonKey(name: "quantity")
  final int? quantity;

  AddToCartRequest ({
    this.product,
    this.quantity,
  });

  factory AddToCartRequest.fromJson(Map<String, dynamic> json) {
    return _$AddToCartRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AddToCartRequestToJson(this);
  }
}


