import 'package:flower_app/features/user_address/data/models/governorate.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../data/models/city.dart';
import '../../domain/entities/address.dart';

sealed class UserAddressEvents {
  const UserAddressEvents();
}

class AddUserAddressEvent extends UserAddressEvents {
  const AddUserAddressEvent(this.address);

  final Address address;
}

class UpdateUserAddressEvent extends UserAddressEvents {
  const UpdateUserAddressEvent(this.address, this.addressId);

  final Address address;
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

class LoadCitiesEvent extends UserAddressEvents {}

class LoadGovernorateEvent extends UserAddressEvents {}

class SetSelectedGovernorateEvent extends UserAddressEvents {
  SetSelectedGovernorateEvent(this.governorate);

  Governorate governorate;
}

class SetSelectedCityEvent extends UserAddressEvents {
  SetSelectedCityEvent(this.city);

  City city;
}

class SetMarkerIconEvent extends UserAddressEvents {}

class SetLocationEvent extends UserAddressEvents {
  SetLocationEvent(this.location);

  LatLng location;
}

class GetLoggedUserAddressEvent extends UserAddressEvents {}
