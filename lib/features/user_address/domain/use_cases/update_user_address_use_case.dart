import 'package:flower_app/features/user_address/domain/entities/address.dart';
import 'package:geocoding/geocoding.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/error_handling/result.dart';
import '../../data/models/address_dto.dart';
import '../repositories/user_address_repo_contract.dart';

@injectable
class UpdateUserAddressUseCase {
  const UpdateUserAddressUseCase(this._userAddressRepo);

  final UserAddressRepoContract _userAddressRepo;

  Future<Result<List<Address>>> call(Address address, String id) async {
    var response = await _userAddressRepo.updateUserAddress(
      AddressDto.fromEntity(address),
      id,
    );
    switch (response) {
      case Success<List<Address>>():
        final addresses = await Future.wait(response.data.map((address) async {
          final placeMarks = await _getPlaceMarks(address.lat, address.long);
          return address.copyWith(placeMarks: placeMarks);
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
