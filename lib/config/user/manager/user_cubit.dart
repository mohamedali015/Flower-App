import 'package:flower_app/config/notification_services/save_user_info_service.dart';
import 'package:flower_app/config/user/manager/user_events.dart';
import 'package:flower_app/config/user/manager/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../error_handling/result.dart';
import '../domain/use_cases/get_user_data_use_case.dart';

@lazySingleton
@lazySingleton
class UserCubit extends Cubit<UserState> {
  final GetUserDataUseCase _getUserDataUseCase;
  final SaveUserInfoService saveUserInfoService;

  UserCubit(this._getUserDataUseCase, this.saveUserInfoService)
    : super(UserState());

  bool _handledUnauthorized = false;
  bool _deviceInitialized = false;

  void doEvent(UserEvents event) {
    switch (event) {
      case GetUserDataEvent():
        _getUserData();
        break;

      case SetUserDataEvent():
        emit(state.copyWith(user: event.user));
        break;

      case UnauthorizedUserEvent():
        _handleUnauthorized();
        break;

      case ResetUnauthorizedEvent():
        _resetUnauthorized();
        break;
    }
  }

  Future<void> _getUserData() async {
    emit(state.copyWith(isLoading: true));

    final response = await _getUserDataUseCase.call();

    switch (response) {
      case Success():
        final user = response.data;

        emit(state.copyWith(isLoading: false, user: user));

        if (user != null && !_deviceInitialized) {
          _deviceInitialized = true;
          await saveUserInfoService.initUserDevice(user.id);
        }

        break;

      case Failure():
        emit(state.copyWith(isLoading: false, error: response.errorMessage));
        break;
    }
  }

  void _resetUnauthorized() {
    _handledUnauthorized = false;
    _deviceInitialized = false;
    emit(state.copyWith(isUnauthorized: false));
  }

  void _handleUnauthorized() {
    if (_handledUnauthorized) return;

    _handledUnauthorized = true;
    _deviceInitialized = false;

    emit(state.copyWith(isUnauthorized: true, user: null));
  }
}
