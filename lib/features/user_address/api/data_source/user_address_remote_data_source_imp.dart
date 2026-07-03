import 'package:flower_app/config/error_handling/execute_api.dart';
import 'package:flower_app/config/error_handling/result.dart';

import 'package:injectable/injectable.dart';

import '../../data/data_sources/user_address_remote_data_source_contract.dart';
import '../../data/models/address_dto.dart';
import '../../data/models/user_address_dto.dart';
import '../user_address_api_client/user_address_api_client.dart';

@Injectable(as: UserAddressRemoteDataSourceContract)
class UserAddressRemoteDataSourceImp
    implements UserAddressRemoteDataSourceContract {
  const UserAddressRemoteDataSourceImp(this._userAddressApiClient);

  final UserAddressApiClient _userAddressApiClient;

  @override
  Future<Result<UserAddressResponseDto>> addUserAddress(AddressDto address) {
    return executeApi(() => _userAddressApiClient.addUserAddress(address));
  }

  @override
  Future<Result<UserAddressResponseDto>> getLoggedUserAddresses() {
    return executeApi(() => _userAddressApiClient.getLoggedUserAddresses());
  }

  @override
  Future<Result<UserAddressResponseDto>> removeUserAddress(String id) {
    return executeApi(() => _userAddressApiClient.removeUserAddress(id));
  }

  @override
  Future<Result<UserAddressResponseDto>> updateUserAddress(
    AddressDto address,
    String id,
  ) {
    return executeApi(
      () => _userAddressApiClient.updateUserAddress(address, id),
    );
  }
}
