import 'package:equatable/equatable.dart';
import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/features/user_address/data/models/city.dart';
import 'package:flower_app/features/user_address/domain/entities/address.dart';

import '../../data/models/governorate.dart';

class UserAddressState extends Equatable {
  const UserAddressState({
    required this.addUserAddressState,
    required this.getLoggedUserAddressState,
    required this.removeUserAddressState,
    required this.updateUserAddressState,
    required this.currentUserAddresses,
    this.mapLoading = false,
    this.governorates,
    this.cities,
    this.selectedGovernorate,
    this.selectedCity,
    this.filteredCities,
  });

  final BaseState addUserAddressState;
  final BaseState updateUserAddressState;
  final BaseState removeUserAddressState;
  final BaseState getLoggedUserAddressState;
  final List<Address>? currentUserAddresses;
  final bool mapLoading;
  final List<Governorate>? governorates;
  final List<City>? cities;
  final List<City>? filteredCities;
  final Governorate? selectedGovernorate;
  final City? selectedCity;

  UserAddressState copyWith({
    BaseState<List<Address>>? addUserAddressState,
    BaseState<List<Address>>? updateUserAddressState,
    BaseState<List<Address>>? removeUserAddressState,
    BaseState<List<Address>>? getLoggedUserAddressState,
    List<Address>? currentUserAddress,
    List<Governorate>? governorates,
    List<City>? cities,
    List<City>? filteredCities,
    bool? mapLoading,
    int? governorateID,
    City? selectedCity,
    Governorate? selectedGovernorate,
  }) {
    return UserAddressState(
      addUserAddressState: addUserAddressState ?? this.addUserAddressState,
      getLoggedUserAddressState:
          getLoggedUserAddressState ?? this.getLoggedUserAddressState,
      removeUserAddressState:
          removeUserAddressState ?? this.removeUserAddressState,
      updateUserAddressState:
          updateUserAddressState ?? this.updateUserAddressState,
      currentUserAddresses: currentUserAddress ?? this.currentUserAddresses,
      mapLoading: mapLoading ?? this.mapLoading,
      governorates: governorates ?? this.governorates,
      cities: cities ?? this.cities,
      filteredCities: filteredCities ?? this.filteredCities,
      selectedCity: selectedCity,
      selectedGovernorate: selectedGovernorate
    );
  }

  @override
  List<Object?> get props => [
    addUserAddressState,
    removeUserAddressState,
    getLoggedUserAddressState,
    updateUserAddressState,
    currentUserAddresses,
    mapLoading,
    governorates,
    cities,
    filteredCities,
    selectedGovernorate,
    selectedCity,
  ];
}
