import 'package:equatable/equatable.dart';
import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/features/user_address/domain/entities/address.dart';

class UserAddressState extends Equatable {
  const UserAddressState({
    required this.addUserAddressState,
    required this.getLoggedUserAddressState,
    required this.removeUserAddressState,
    required this.updateUserAddressState,
    required this.currentUserAddress,
  });

  final BaseState addUserAddressState;
  final BaseState updateUserAddressState;
  final BaseState removeUserAddressState;
  final BaseState getLoggedUserAddressState;
  final List<Address>? currentUserAddress;

  UserAddressState copyWith({
    BaseState<List<Address>>? addUserAddressState,
    BaseState<List<Address>>? updateUserAddressState,
    BaseState<List<Address>>? removeUserAddressState,
    BaseState<List<Address>>? getLoggedUserAddressState,
    List<Address>? currentUserAddress,
  }) {
    return UserAddressState(
      addUserAddressState: addUserAddressState ?? this.addUserAddressState,
      getLoggedUserAddressState:
          getLoggedUserAddressState ?? this.getLoggedUserAddressState,
      removeUserAddressState:
          removeUserAddressState ?? this.removeUserAddressState,
      updateUserAddressState:
          updateUserAddressState ?? this.updateUserAddressState,
      currentUserAddress: currentUserAddress ?? this.currentUserAddress,
    );
  }

  @override
  List<Object?> get props => [
    addUserAddressState,
    removeUserAddressState,
    getLoggedUserAddressState,
    updateUserAddressState,
    currentUserAddress,
  ];
}
