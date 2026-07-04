import 'package:flower_app/config/error_handling/result.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/address.dart';
import '../../domain/repositories/user_address_repo_contract.dart';
import '../data_sources/user_address_remote_data_source_contract.dart';
import '../models/address_dto.dart';
import '../models/user_address_dto.dart';

@Injectable(as: UserAddressRepoContract)
class UserAddressRepoImp implements UserAddressRepoContract {
  const UserAddressRepoImp(this._dataSource);

  final UserAddressRemoteDataSourceContract _dataSource;

  @override
  Future<Result<List<Address>>> addUserAddress(AddressDto address) async {
    var response = await _dataSource.addUserAddress(address);
    switch (response) {
      case Success<UserAddressResponseDto>():
        final addresses =
            response.data.addresses!.map((e) => e.toEntity()).toList();
        return Success(
          data: addresses,
        );
      case Failure<UserAddressResponseDto>():
        return Failure(errorMessage: response.errorMessage);
    }
  }

  @override
  Future<Result<List<Address>>> getLoggedUserAddresses() async {
    var response = await _dataSource.getLoggedUserAddresses();
    switch (response) {
      case Success<UserAddressResponseDto>():
        final addresses =
            response.data.addresses!.map((e) => e.toEntity()).toList();
        return Success(
          data: addresses,
        );
      case Failure<UserAddressResponseDto>():
        return Failure(errorMessage: response.errorMessage);
    }
  }

  @override
  Future<Result<List<Address>>> removeUserAddress(String id) async {
    var response = await _dataSource.removeUserAddress(id);
    switch (response) {
      case Success<UserAddressResponseDto>():
        final addresses =
            response.data.addresses!.map((e) => e.toEntity()).toList();
        return Success(
          data: addresses,
        );
      case Failure<UserAddressResponseDto>():
        return Failure(errorMessage: response.errorMessage);
    }
  }

  @override
  Future<Result<List<Address>>> updateUserAddress(
    AddressDto address,
    String id,
  ) async {
    var response = await _dataSource.updateUserAddress(address, id);
    switch (response) {
      case Success<UserAddressResponseDto>():
        final addresses =
            response.data.addresses!.map((e) => e.toEntity()).toList();
        return Success(
          data: addresses,
        );
      case Failure<UserAddressResponseDto>():
        return Failure(errorMessage: response.errorMessage);
    }
  }
}
