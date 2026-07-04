import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/address.dart';

part 'address_dto.g.dart';

@JsonSerializable()
class AddressDto {
  @JsonKey(name: "street")
  String? street;
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "city")
  String? city;
  @JsonKey(name: "lat")
  String? lat;
  @JsonKey(name: "long")
  String? long;
  @JsonKey(name: "username")
  String? username;
  @JsonKey(name: "_id", includeToJson: false)
  String? id;

  AddressDto({
    this.street,
    this.phone,
    this.city,
    this.lat,
    this.long,
    this.username,
    this.id,
  });

  factory AddressDto.fromJson(Map<String, dynamic> json) =>
      _$AddressDtoFromJson(json);

  factory AddressDto.fromEntity(Address address) {
    return AddressDto(
      street: address.street,
      phone: address.phone,
      city: address.city,
      lat: address.lat,
      long: address.long,
      username: address.username,
      id: address.id,
    );
  }

  Map<String, dynamic> toJson() => _$AddressDtoToJson(this);

  Address toEntity() {
    return Address(
      street: street,
      phone: phone,
      city: city,
      lat: lat,
      long: long,
      username: username,
      id: id,
      placeMarks: const [],
    );
  }
}
