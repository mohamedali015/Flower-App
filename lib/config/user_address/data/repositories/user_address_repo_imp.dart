import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/config/user_address/data/data_sources/user_address_remote_data_source_contract.dart';
import 'package:flower_app/config/user_address/data/models/address_dto.dart';
import 'package:flower_app/config/user_address/data/models/user_address_dto.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/user_address_repo_contract.dart';

@Injectable(as: UserAddressRepoContract)
class UserAddressRepoImp implements UserAddressRepoContract {
  const UserAddressRepoImp(this._dataSource);

  final UserAddressRemoteDataSourceContract _dataSource;

  @override
  Future<Result<UserAddressDto>> addUserAddress(AddressDto address) async {
    var response = await _dataSource.addUserAddress(address);
    switch (response) {
      case Success<UserAddressDto>():
        return Success(data: response.data);
      case Failure<UserAddressDto>():
        return Failure(errorMessage: response.errorMessage);
    }
  }

  @override
  Future<Result<UserAddressDto>> getLoggedUserAddress() async {
    var response = await _dataSource.getLoggedUserAddress();
    switch (response) {
      case Success<UserAddressDto>():
        return Success(data: response.data);
      case Failure<UserAddressDto>():
        return Failure(errorMessage: response.errorMessage);
    }
  }

  @override
  Future<Result<UserAddressDto>> removeUserAddress(String id) async {
    var response = await _dataSource.removeUserAddress(id);
    switch (response) {
      case Success<UserAddressDto>():
        return Success(data: response.data);
      case Failure<UserAddressDto>():
        return Failure(errorMessage: response.errorMessage);
    }
  }

  @override
  Future<Result<UserAddressDto>> updateUserAddress(
    AddressDto address,
    String id,
  ) async {
    var response = await _dataSource.updateUserAddress(address, id);
    switch (response) {
      case Success<UserAddressDto>():
        return Success(data: response.data);
      case Failure<UserAddressDto>():
        return Failure(errorMessage: response.errorMessage);
    }
  }
}
