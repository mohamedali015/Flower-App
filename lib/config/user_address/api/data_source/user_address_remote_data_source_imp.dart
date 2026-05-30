import 'package:flower_app/config/error_handling/execute_api.dart';
import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/config/user_address/api/user_address_api_client/user_address_api_client.dart';
import 'package:flower_app/config/user_address/data/data_sources/user_address_remote_data_source_contract.dart';
import 'package:flower_app/config/user_address/data/models/address_dto.dart';
import 'package:flower_app/config/user_address/data/models/user_address_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: UserAddressRemoteDataSourceContract)
class UserAddressRemoteDataSourceImp
    implements UserAddressRemoteDataSourceContract {
  const UserAddressRemoteDataSourceImp(this._userAddressApiClient);

  final UserAddressApiClient _userAddressApiClient;

  @override
  Future<Result<UserAddressDto>> addUserAddress(AddressDto address) {
    return executeApi(() => _userAddressApiClient.addUserAddress(address));
  }

  @override
  Future<Result<UserAddressDto>> getLoggedUserAddress() {
    return executeApi(() => _userAddressApiClient.getLoggedUserAddress());
  }

  @override
  Future<Result<UserAddressDto>> removeUserAddress(String id) {
    return executeApi(() => _userAddressApiClient.removeUserAddress(id));
  }

  @override
  Future<Result<UserAddressDto>> updateUserAddress(
    AddressDto address,
    String id,
  ) {
    return executeApi(
      () => _userAddressApiClient.updateUserAddress(address, id),
    );
  }
}
