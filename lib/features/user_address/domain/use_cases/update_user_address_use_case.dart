import 'package:flower_app/features/user_address/domain/entities/address.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/error_handling/result.dart';
import '../../data/models/address_dto.dart';
import '../repositories/user_address_repo_contract.dart';

@injectable
class UpdateUserAddressUseCase {
  const UpdateUserAddressUseCase(this._userAddressRepo);

  final UserAddressRepoContract _userAddressRepo;

  Future<Result<List<Address>>> call(AddressDto address, String id) async {
    var response = await _userAddressRepo.updateUserAddress(address, id);
    switch (response) {
      case Success<List<Address>>():
        return Success(data: response.data);
      case Failure<List<Address>>():
        return Failure(errorMessage: response.errorMessage);
    }
  }
}
