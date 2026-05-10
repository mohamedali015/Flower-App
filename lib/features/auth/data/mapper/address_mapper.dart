import 'package:flower_app/features/auth/data/model/response/address_response.dart';
import 'package:flower_app/features/auth/domain/entities/address_entity.dart';

extension AddressMapper on AddressResponse {
  AddressEntity toEntity() {
    return AddressEntity(
      id: id ?? '',
      street: street ?? '',
      phone: phone ?? '',
      city: city ?? '',
      lat: lat ?? '',
      long: long ?? '',
      username: username ?? '',
    );
  }
}
