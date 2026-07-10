import 'package:flower_app/features/user_address/domain/entities/address.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/error_handling/result.dart';
import '../repositories/user_address_repo_contract.dart';

@injectable
class RemoveUserAddressUseCase {
  const RemoveUserAddressUseCase(this._userAddressRepo);

  final UserAddressRepoContract _userAddressRepo;
  Future<Result<List<Address>>> call(String id) async {
    var response = await _userAddressRepo.removeUserAddress(id);
    switch (response) {
      case Success<List<Address>>():
        return Success(data: response.data);
      case Failure<List<Address>>():
        return Failure(errorMessage: response.errorMessage);
    }
  }
}
