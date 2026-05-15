import '../../../products/data/mapper/product_mapper.dart';
import '../../domain/entities/user_entity.dart';
import '../models/responses/get_user_response/user_response.dart';
import 'address_mapper.dart';

extension UserMapper on UserResponse {
  UserEntity toEntity() {
    return UserEntity(
      id: id ?? '',
      firstName: firstName ?? '',
      lastName: lastName ?? '',
      email: email ?? '',
      gender: gender ?? '',
      phone: phone ?? '',
      userPhoto: photo ?? '',
      role: role ?? '',
      wishList: wishlist?.map((product) => product.toEntity).toList() ?? [],
      addresses: addresses?.map((address) => address.toEntity).toList() ?? [],
      createdAt: createdAt ?? DateTime.fromMillisecondsSinceEpoch(0),
    );
  }
}
