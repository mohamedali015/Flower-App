import 'package:flower_app/features/user_address/domain/entities/address.dart';
import 'package:geocoding/geocoding.dart';
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
        final addresses = await Future.wait(response.data.map((item) async {
          final fetchedPlaceMarks = await _getPlaceMarks(item.lat, item.long);
          return item.copyWith(placeMarks: fetchedPlaceMarks);
        }));
        return Success(data: addresses);
      case Failure<List<Address>>():
        return Failure(errorMessage: response.errorMessage);
    }
  }

  Future<List<Placemark>> _getPlaceMarks(String? lat, String? long) async {
    final latitude = double.tryParse(lat ?? '');
    final longitude = double.tryParse(long ?? '');
    if (latitude != null && longitude != null) {
      try {
        return await placemarkFromCoordinates(latitude, longitude);
      } catch (e) {
        return [];
      }
    }
    return [];
  }
}
