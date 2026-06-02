import 'package:injectable/injectable.dart';

import '../../../../config/error_handling/result.dart';
import '../../data/models/user_address_dto.dart';
import '../repositories/user_address_repo_contract.dart';

@injectable
class GetLoggedUserAddressUseCase {
  const GetLoggedUserAddressUseCase(this._userAddressRepo);

  final UserAddressRepoContract _userAddressRepo;
  Future<Result<UserAddressDto>> call() async {
    var response = await _userAddressRepo.getLoggedUserAddress();
    switch (response) {
      case Success<UserAddressDto>():
        return Success(data: response.data);
      case Failure<UserAddressDto>():
        return Failure(errorMessage: response.errorMessage);
    }
  }
}
