import 'package:equatable/equatable.dart';
import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/features/user_address/data/models/city.dart';
import 'package:flower_app/features/user_address/domain/entities/address.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../data/models/governorate.dart';

class UserAddressState extends Equatable {
  const UserAddressState({
    required this.addUserAddressState,
    required this.getLoggedUserAddressesState,
    required this.removeUserAddressState,
    required this.updateUserAddressState,
    required this.currentUserAddresses,
    this.selectedAddress,
    this.mapLoading = false,
    this.governorates,
    this.cities,
    this.selectedGovernorate,
    this.selectedCity,
    this.filteredCities,
    this.selectedLocation,
    this.markerIcon
  });

  final BaseState addUserAddressState;
  final BaseState updateUserAddressState;
  final BaseState removeUserAddressState;
  final BaseState getLoggedUserAddressesState;
  final List<Address>? currentUserAddresses;
  final Address? selectedAddress;
  final bool mapLoading;
  final List<Governorate>? governorates;
  final List<City>? cities;
  final List<City>? filteredCities;
  final Governorate? selectedGovernorate;
  final City? selectedCity;
  final LatLng? selectedLocation;
  final BitmapDescriptor? markerIcon;

  UserAddressState copyWith({
    BaseState<List<Address>>? addUserAddressState,
    BaseState<List<Address>>? updateUserAddressState,
    BaseState<List<Address>>? removeUserAddressState,
    BaseState<List<Address>>? getLoggedUserAddressesState,
    List<Address>? currentUserAddresses,
    Address? selectedAddress,
    List<Governorate>? governorates,
    List<City>? cities,
    List<City>? filteredCities,
    bool? mapLoading,
    int? governorateID,
    City? selectedCity,
    LatLng? selectedLocation,
    Governorate? selectedGovernorate,
    BitmapDescriptor? markerIcon,
  }) {
    return UserAddressState(
      addUserAddressState: addUserAddressState ?? this.addUserAddressState,
      getLoggedUserAddressesState:
          getLoggedUserAddressesState ?? this.getLoggedUserAddressesState,
      removeUserAddressState:
          removeUserAddressState ?? this.removeUserAddressState,
      updateUserAddressState:
          updateUserAddressState ?? this.updateUserAddressState,
      currentUserAddresses: currentUserAddresses ?? this.currentUserAddresses,
      selectedAddress: selectedAddress ?? this.selectedAddress,
      mapLoading: mapLoading ?? this.mapLoading,
      governorates: governorates ?? this.governorates,
      cities: cities ?? this.cities,
      filteredCities: filteredCities,
      selectedCity: selectedCity,
      selectedGovernorate: selectedGovernorate,
      selectedLocation: selectedLocation,
      markerIcon: markerIcon ?? this.markerIcon
    );
  }

  @override
  List<Object?> get props => [
    addUserAddressState,
    removeUserAddressState,
    getLoggedUserAddressesState,
    updateUserAddressState,
    currentUserAddresses,
    selectedAddress,
    mapLoading,
    governorates,
    cities,
    filteredCities,
    selectedGovernorate,
    selectedCity,
    selectedLocation,
    markerIcon
  ];
}
