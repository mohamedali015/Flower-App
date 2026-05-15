import 'package:flower_app/config/user/data/models/responses/get_user_response/address_response.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../../products/data/model/response/product_model.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  @JsonKey(name: "firstName")
  String? firstName;
  @JsonKey(name: "lastName")
  String? lastName;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "gender")
  String? gender;
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "photo")
  String? photo;
  @JsonKey(name: "role")
  String? role;
  @JsonKey(name: "wishlist")
  List<ProductModel>? wishlist;
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "addresses")
  List<AddressResponse>? addresses;
  @JsonKey(name: "createdAt")
  DateTime? createdAt;

  UserResponse({
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.phone,
    this.photo,
    this.role,
    this.wishlist,
    this.id,
    this.addresses,
    this.createdAt,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
}
