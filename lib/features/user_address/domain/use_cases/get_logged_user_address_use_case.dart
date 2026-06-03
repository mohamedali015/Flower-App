import 'package:flower_app/features/user_address/domain/entities/address.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/error_handling/result.dart';
import '../../data/models/user_address_dto.dart';
import '../repositories/user_address_repo_contract.dart';

@injectable
class GetLoggedUserAddressUseCase {
  const GetLoggedUserAddressUseCase(this._userAddressRepo);

  final UserAddressRepoContract _userAddressRepo;
  Future<Result<List<Address>>> call() async {
    var response = await _userAddressRepo.getLoggedUserAddress();
    switch (response) {
      case Success<List<Address>>():
        return Success(data: response.data);
      case Failure<List<Address>>():
        return Failure(errorMessage: response.errorMessage);
    }
  }
}
