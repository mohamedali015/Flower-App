import 'package:equatable/equatable.dart';
import 'package:flower_app/config/base_state/base_state.dart';
import 'package:geocoding/geocoding.dart';

import '../data/models/user_address_dto.dart';


class UserAddressState extends Equatable {
  const UserAddressState({
    required this.addUserAddressState,
    required this.getLoggedUserAddressState,
    required this.removeUserAddressState,
    required this.updateUserAddressState,
    required this.placeMark,
    required this.currentUserAddress
  });

  final BaseState addUserAddressState;
  final BaseState updateUserAddressState;
  final BaseState removeUserAddressState;
  final BaseState<UserAddressDto> getLoggedUserAddressState;
  final BaseState<List<Placemark>> placeMark;
  final UserAddressDto? currentUserAddress;

  UserAddressState copyWith({
    BaseState<UserAddressDto>? addUserAddressState,
    BaseState<UserAddressDto>? updateUserAddressState,
    BaseState<UserAddressDto>? removeUserAddressState,
    BaseState<UserAddressDto>? getLoggedUserAddressState,
    BaseState<List<Placemark>>? placeMark,
    UserAddressDto? currentUserAddress,
  }) {
    return UserAddressState(
      addUserAddressState: addUserAddressState ?? this.addUserAddressState,
      getLoggedUserAddressState:
          getLoggedUserAddressState ?? this.getLoggedUserAddressState,
      removeUserAddressState:
          removeUserAddressState ?? this.removeUserAddressState,
      updateUserAddressState:
          updateUserAddressState ?? this.updateUserAddressState,
      placeMark: placeMark ?? this.placeMark,
      currentUserAddress: currentUserAddress ?? this.currentUserAddress
    );
  }

  @override
  List<Object?> get props => [
    addUserAddressState,
    removeUserAddressState,
    getLoggedUserAddressState,
    updateUserAddressState,
    placeMark,
  ];
}
