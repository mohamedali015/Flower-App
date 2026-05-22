import 'dart:io';

import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/edit_profile/domain/params/edit_profile_params.dart';
import 'package:flower_app/features/edit_profile/domain/use_case/edit_profile_use_case.dart';
import 'package:flower_app/features/edit_profile/domain/use_case/upload_image_use_case.dart';
import 'package:flower_app/features/edit_profile/presentation/manager/edit_profile_events.dart';
import 'package:flower_app/features/edit_profile/presentation/manager/edit_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit(this._editProfileUseCase, this._uploadPhotoUseCase)
    : super(const EditProfileState());

  final EditProfileUseCase _editProfileUseCase;
  final UploadPhotoUseCase _uploadPhotoUseCase;

  void doEvent(EditProfileEvents event) {
    switch (event) {
      case EditProfileEvent():
        _editProfile(event);

      case UploadProfileImageEvent():
        _uploadProfileImage(image: event.image);

      case CheckChangesEvent():
        _checkChanges(event);
    }
  }

  void _checkChanges(CheckChangesEvent event) {
    final hasChanged =
        event.firstName.trim() != event.user.firstName ||
        event.lastName.trim() != event.user.lastName ||
        event.email.trim() != event.user.email ||
        event.phone.trim() != event.user.phone;

    if (hasChanged == state.isChanged) {
      return;
    }

    emit(state.copyWith(isChangedParam: hasChanged));
  }

  Future<void> _editProfile(EditProfileEvent event) async {
    emit(
      state.copyWith(
        editProfileStateParam: state.editProfileState.copyWith(
          isLoadingParam: true,
          isSuccessParam: false,
          errorMessageParam: null,
        ),
      ),
    );

    final result = await _editProfileUseCase.call(
      params: EditProfileParams(
        firstName: event.firstName,
        lastName: event.lastName,
        email: event.email,
        phone: event.phone,
      ),
    );

    switch (result) {
      case Success():
        {
          emit(
            state.copyWith(
              editProfileStateParam: state.editProfileState.copyWith(
                isLoadingParam: false,
                isSuccessParam: true,
                dataParam: result.data,
              ),

              isChangedParam: false,
            ),
          );
        }

      case Failure():
        {
          emit(
            state.copyWith(
              editProfileStateParam: state.editProfileState.copyWith(
                isLoadingParam: false,
                isSuccessParam: false,
                errorMessageParam: result.errorMessage,
              ),
            ),
          );
        }
    }
  }

  Future<void> _uploadProfileImage({required File image}) async {
    emit(
      state.copyWith(
        uploadProfileImageStateParam: state.uploadProfileImageState.copyWith(
          isLoadingParam: true,
          isSuccessParam: false,
          errorMessageParam: null,
        ),
      ),
    );

    final result = await _uploadPhotoUseCase.call(image: image);

    switch (result) {
      case Success():
        {
          emit(
            state.copyWith(
              uploadProfileImageStateParam: state.uploadProfileImageState
                  .copyWith(
                    isLoadingParam: false,
                    isSuccessParam: true,
                    dataParam: true,
                  ),
            ),
          );
        }

      case Failure():
        {
          emit(
            state.copyWith(
              uploadProfileImageStateParam: state.uploadProfileImageState
                  .copyWith(
                    isLoadingParam: false,
                    isSuccessParam: false,
                    errorMessageParam: result.errorMessage,
                  ),
            ),
          );
        }
    }
  }
}
