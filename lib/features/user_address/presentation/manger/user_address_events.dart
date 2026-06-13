import '../../data/models/address_dto.dart';

sealed class UserAddressEvents {
  const UserAddressEvents();
}

class AddUserAddressEvent extends UserAddressEvents {
  const AddUserAddressEvent(this.address);

  final AddressDto address;
}

class UpdateUserAddressEvent extends UserAddressEvents {
  const UpdateUserAddressEvent(this.address, this.addressId);

  final AddressDto address;
  final String addressId;
}

class RemoveUserAddressEvent extends UserAddressEvents {
  const RemoveUserAddressEvent(this.addressId);

  final String addressId;
}

class MapLoadingEvent extends UserAddressEvents {
  bool mapLoading;

  MapLoadingEvent(this.mapLoading);
}

class LoadCitiesEvent extends UserAddressEvents {
  int governorateID;

  LoadCitiesEvent(this.governorateID);
}

class LoadGovernorateEvent extends UserAddressEvents {}

class ClearCitiesListEvent extends UserAddressEvents{}

class GetLoggedUserAddressEvent extends UserAddressEvents {}
