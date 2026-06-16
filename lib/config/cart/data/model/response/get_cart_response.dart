
import 'package:json_annotation/json_annotation.dart';

import 'cart_item_response.dart';
part 'get_cart_response.g.dart';
@JsonSerializable()
class Cart {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "user")
  final String? user;
  @JsonKey(name: "cartItems")
  final List<CartItems>? cartItems;
  @JsonKey(name: "appliedCoupons")
  final List<dynamic>? appliedCoupons;
  @JsonKey(name: "discount")
  final int? discount;
  @JsonKey(name: "totalPrice")
  final int? totalPrice;
  @JsonKey(name: "totalPriceAfterDiscount")
  final int? totalPriceAfterDiscount;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;
  @JsonKey(name: "__v")
  final int? V;

  Cart ({
    this.id,
    this.user,
    this.cartItems,
    this.appliedCoupons,
    this.discount,
    this.totalPrice,
    this.totalPriceAfterDiscount,
    this.createdAt,
    this.updatedAt,
    this.V,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return _$CartFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CartToJson(this);
  }
}
