

import 'package:flower_app/config/user_address/data/models/address_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_address_dto.g.dart';
@JsonSerializable()
class UserAddressDto {
  @JsonKey(name: "message")
  String? message;

  @JsonKey(
    readValue: _readAddress,
  )
  List<AddressDto>? address;

  UserAddressDto({
    this.message,
    this.address,
  });

  static Object? _readAddress(Map json, String key) {
    return json["addresses"] ?? json["address"];
  }

  factory UserAddressDto.fromJson(Map<String, dynamic> json) =>
      _$UserAddressDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserAddressDtoToJson(this);
}