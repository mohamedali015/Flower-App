import 'package:flower_app/config/user/data/models/responses/get_user_response/address_response.dart';
import 'package:flower_app/config/user/domain/entities/address_entity.dart';

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
