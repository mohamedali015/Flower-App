import 'package:geocoding/geocoding.dart';
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

  Map<String, dynamic> toJson() => _$AddressDtoToJson(this);

  Future<Address> toEntity() async {
    final latitude = double.tryParse(lat ?? '');
    final longitude = double.tryParse(long ?? '');

    List<Placemark> placeMarks = [];

    if (latitude != null && longitude != null) {
      placeMarks = await placemarkFromCoordinates(latitude, longitude);
    }

    return Address(
      street: street,
      phone: phone,
      city: city,
      lat: lat,
      long: long,
      username: username,
      id: id,
      placeMarks: placeMarks,
    );
  }
}
