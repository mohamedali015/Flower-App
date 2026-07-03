import 'package:flower_app/config/error_handling/result.dart';

import '../models/address_dto.dart';
import '../models/user_address_dto.dart';

abstract interface class UserAddressRemoteDataSourceContract {
  Future<Result<UserAddressResponseDto>> getLoggedUserAddresses();

  Future<Result<UserAddressResponseDto>> addUserAddress(AddressDto address);

  Future<Result<UserAddressResponseDto>> updateUserAddress(
    AddressDto address,
    String id,
  );

  Future<Result<UserAddressResponseDto>> removeUserAddress(String id);
}
