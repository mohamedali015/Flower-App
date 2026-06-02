import 'package:flower_app/config/error_handling/result.dart';

import 'package:injectable/injectable.dart';

import '../../data/models/address_dto.dart';
import '../../data/models/user_address_dto.dart';
import '../repositories/user_address_repo_contract.dart';

@injectable
class AddUserAddressUseCase {
  const AddUserAddressUseCase(this._userAddressRepo);

  final UserAddressRepoContract _userAddressRepo;

  Future<Result<UserAddressDto>> call(AddressDto address) async {
    var response = await _userAddressRepo.addUserAddress(address);
    switch (response) {
      case Success<UserAddressDto>():
        return Success(data: response.data);
      case Failure<UserAddressDto>():
        return Failure(errorMessage: response.errorMessage);
    }
  }
}
