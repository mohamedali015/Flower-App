import 'package:json_annotation/json_annotation.dart';

import 'address_dto.dart';

part 'user_address_dto.g.dart';
@JsonSerializable()
class UserAddressResponseDto {
  @JsonKey(name: "message")
  String? message;

  @JsonKey(
    readValue: _readAddress,
  )
  List<AddressDto>? addresses;

  UserAddressResponseDto({
    this.message,
    this.addresses,
  });

  static Object? _readAddress(Map json, String key) {
    return json["addresses"] ?? json["address"];
  }

  factory UserAddressResponseDto.fromJson(Map<String, dynamic> json) =>
      _$UserAddressResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserAddressResponseDtoToJson(this);
}
