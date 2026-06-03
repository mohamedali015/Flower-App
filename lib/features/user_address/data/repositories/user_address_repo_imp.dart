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
      case Success<UserAddressDto>():
        final addresses = await Future.wait(
          response.data.address!.map((e) => e.toEntity()),
        );
        return Success(
          data: addresses,
        );
      case Failure<UserAddressDto>():
        return Failure(errorMessage: response.errorMessage);
    }
  }

  @override
  Future<Result<List<Address>>> getLoggedUserAddress() async {
    var response = await _dataSource.getLoggedUserAddress();
    switch (response) {
      case Success<UserAddressDto>():
        final addresses = await Future.wait(
          response.data.address!.map((e) => e.toEntity()),
        );
        return Success(
          data: addresses,
        );
      case Failure<UserAddressDto>():
        return Failure(errorMessage: response.errorMessage);
    }
  }

  @override
  Future<Result<List<Address>>> removeUserAddress(String id) async {
    var response = await _dataSource.removeUserAddress(id);
    switch (response) {
      case Success<UserAddressDto>():
        final addresses = await Future.wait(
          response.data.address!.map((e) => e.toEntity()),
        );
        return Success(
          data: addresses,
        );
      case Failure<UserAddressDto>():
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
      case Success<UserAddressDto>():
        final addresses = await Future.wait(
          response.data.address!.map((e) => e.toEntity()),
        );
        return Success(
          data: addresses,
        );
      case Failure<UserAddressDto>():
        return Failure(errorMessage: response.errorMessage);
    }
  }
}
