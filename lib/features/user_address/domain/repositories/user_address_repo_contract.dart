import '../../../../config/error_handling/result.dart';
import '../../data/models/address_dto.dart';
import '../entities/address.dart';

abstract interface class UserAddressRepoContract {
  Future<Result<List<Address>>> getLoggedUserAddresses();

  Future<Result<List<Address>>> addUserAddress(AddressDto address);

  Future<Result<List<Address>>> updateUserAddress(
    AddressDto address,
    String id,
  );

  Future<Result<List<Address>>> removeUserAddress(String id);
}
