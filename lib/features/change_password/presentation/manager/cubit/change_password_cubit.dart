import 'package:equatable/equatable.dart';
import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/change_password/domain/entities/change_password_request_entity.dart';
import 'package:flower_app/features/change_password/domain/entities/change_password_response_entity.dart';
import 'package:flower_app/features/change_password/domain/use_cases/change_password_use_case.dart';
import 'package:flower_app/features/change_password/presentation/manager/cubit/change_password_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'change_password_state.dart';

@injectable
class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordUseCase _changePasswordUseCase;

  ChangePasswordCubit({required ChangePasswordUseCase changePasswordUseCase})
    : _changePasswordUseCase = changePasswordUseCase,
      super(ChangePasswordInitial());

  void doEvents(ChangePasswordEvents event) {
    switch (event) {
      case SubmitChangePasswordEvent():
        _changePassword(
          changePasswordRequestEntity: event.changePasswordRequestEntity,
        );
        break;
    }
  }

  Future<void> _changePassword({
    required ChangePasswordRequestEntity changePasswordRequestEntity,
  }) async {
    emit(ChangePasswordLoading());

    final result = await _changePasswordUseCase.changePassword(
      changePasswordRequestEntity: changePasswordRequestEntity,
    );

    switch (result) {
      case Success<ChangePasswordResponseEntity>():
        emit(ChangePasswordSuccess(changePasswordResponseEntity: result.data));
      case Failure<ChangePasswordResponseEntity>():
        emit(ChangePasswordError(errorMessage: result.errorMessage));
    }
  }
}
