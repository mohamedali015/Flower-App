import 'package:injectable/injectable.dart';

import '../../../error_handling/result.dart';
import '../../data/models/user_address_dto.dart';
import '../repositories/user_address_repo_contract.dart';

@injectable
class RemoveUserAddressUseCase {
  const RemoveUserAddressUseCase(this._userAddressRepo);

  final UserAddressRepoContract _userAddressRepo;
  Future<Result<UserAddressDto>> call(String id) async {
    var response = await _userAddressRepo.removeUserAddress(id);
    switch (response) {
      case Success<UserAddressDto>():
        return Success(data: response.data);
      case Failure<UserAddressDto>():
        return Failure(errorMessage: response.errorMessage);
    }
  }
}
