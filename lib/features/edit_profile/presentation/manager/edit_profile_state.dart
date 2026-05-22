import 'package:equatable/equatable.dart';
import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/features/auth/domain/entities/auth_entity.dart';

class EditProfileState extends Equatable {
  final BaseState<AuthEntity> editProfileState;

  final BaseState<bool> uploadProfileImageState;

  final bool isChanged;

  const EditProfileState({
    this.editProfileState = const BaseState(),

    this.uploadProfileImageState = const BaseState(),

    this.isChanged = false,
  });

  EditProfileState copyWith({
    BaseState<AuthEntity>? editProfileStateParam,

    BaseState<bool>? uploadProfileImageStateParam,

    bool? isChangedParam,
  }) {
    return EditProfileState(
      editProfileState: editProfileStateParam ?? editProfileState,

      uploadProfileImageState:
          uploadProfileImageStateParam ?? uploadProfileImageState,

      isChanged: isChangedParam ?? isChanged,
    );
  }

  @override
  List<Object?> get props => [
    editProfileState,
    uploadProfileImageState,
    isChanged,
  ];
}
