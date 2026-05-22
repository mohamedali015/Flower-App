import 'package:flower_app/config/user/domain/use_cases/logout_use_case.dart';
import 'package:flower_app/config/user/manager/user_events.dart';
import 'package:flower_app/config/user/manager/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../error_handling/result.dart';
import '../domain/use_cases/get_user_data_use_case.dart';

@lazySingleton
class UserCubit extends Cubit<UserState> {
  UserCubit(this._getUserDataUseCase ) : super(UserState());

  final GetUserDataUseCase _getUserDataUseCase;
  // final LogoutUseCase _logoutUseCase;
  bool _handledUnauthorized = false;

  /// events
  void doEvent(UserEvents event) {
    switch (event) {
      case GetUserDataEvent():
        {
          _getUserData();
          break;
        }
      case SetUserDataEvent():
        {
          emit(state.copyWith(user: event.user));
          break;
        }
      case UnauthorizedUserEvent():
        {
          _handleUnauthorized();
          break;
        }
      case ResetUnauthorizedEvent():
        {
          _resetUnauthorized();
          break;
        }
    /*  case LogoutUserEvent():
        _logout();*/
    }
  }

  Future<void> _getUserData() async {
    print("called");
    emit(state.copyWith(isLoading: true));
    final response = await _getUserDataUseCase.call();

    switch (response) {
      case Success():
        emit(state.copyWith(isLoading: false, user: response.data));
        break;

      case Failure():
        emit(state.copyWith(isLoading: false, error: response.errorMessage));
        break;
    }
  }

  void _resetUnauthorized() {
    _handledUnauthorized = false;
    emit(state.copyWith(isUnauthorized: false));
  }

  void _handleUnauthorized() {
    if (_handledUnauthorized) return;
    _handledUnauthorized = true;

    emit(state.copyWith(isUnauthorized: true, user: null));
  }

  /*void _logout() {
  }*/
}
