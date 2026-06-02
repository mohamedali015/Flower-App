import '../../../../config/error_handling/result.dart';

import '../../data/models/address_dto.dart';
import '../../data/models/user_address_dto.dart';

abstract interface class UserAddressRepoContract {
  Future<Result<UserAddressDto>> getLoggedUserAddress();

  Future<Result<UserAddressDto>> addUserAddress(AddressDto address);

  Future<Result<UserAddressDto>> updateUserAddress(
    AddressDto address,
    String id,
  );

  Future<Result<UserAddressDto>> removeUserAddress(String id);
}
