import 'package:flower_app/config/base_state/base_state.dart';

class UserAddressState {
  const UserAddressState({
    required this.addUserAddressState,
    required this.getLoggedUserAddressState,
    required this.removeUserAddressState,
    required this.updateUserAddressState,
  });

  final BaseState addUserAddressState;
  final BaseState updateUserAddressState;
  final BaseState removeUserAddressState;
  final BaseState getLoggedUserAddressState;

  UserAddressState copyWith({
    BaseState? addUserAddressState,
    BaseState? updateUserAddressState,
    BaseState? removeUserAddressState,
    BaseState? getLoggedUserAddressState,
  }) {
    return UserAddressState(
      addUserAddressState: addUserAddressState ?? this.addUserAddressState,
      getLoggedUserAddressState:
          getLoggedUserAddressState ?? this.getLoggedUserAddressState,
      removeUserAddressState:
          removeUserAddressState ?? this.removeUserAddressState,
      updateUserAddressState:
          updateUserAddressState ?? this.updateUserAddressState,
    );
  }
}
