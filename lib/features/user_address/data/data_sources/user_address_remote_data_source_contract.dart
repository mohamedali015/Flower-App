import 'package:flower_app/config/error_handling/result.dart';

import '../models/address_dto.dart';
import '../models/user_address_dto.dart';

abstract interface class UserAddressRemoteDataSourceContract {
  Future<Result<UserAddressDto>> getLoggedUserAddress();

  Future<Result<UserAddressDto>> addUserAddress(AddressDto address);

  Future<Result<UserAddressDto>> updateUserAddress(
    AddressDto address,
    String id,
  );

  Future<Result<UserAddressDto>> removeUserAddress(String id);
}
