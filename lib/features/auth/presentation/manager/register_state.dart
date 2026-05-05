import 'package:equatable/equatable.dart';
import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/features/auth/domain/entities/auth_entity.dart';
import 'package:flower_app/features/auth/presentation/pages/register/register_screen.dart';

class RegisterState extends Equatable {
  final BaseState<AuthEntity> registerState;
  final UserGender gender;
  final bool isSubmitted;
  final bool isPasswordHidden;
  final bool isConfirmPasswordHidden;

  const RegisterState({
    BaseState<AuthEntity>? registerState,
    this.gender = UserGender.female,
    this.isSubmitted = false,
    this.isPasswordHidden = true,
    this.isConfirmPasswordHidden = true,
  }) : registerState = registerState ?? const BaseState();

  RegisterState copyWith({
    BaseState<AuthEntity>? registerStateParam,
    UserGender? genderParam,
    bool? isSubmittedParam,
    bool? isPasswordHiddenParam,
    bool? isConfirmPasswordHiddenParam,
  }) {
    return RegisterState(
      registerState: registerStateParam ?? registerState,
      gender: genderParam ?? gender,
      isSubmitted: isSubmittedParam ?? isSubmitted,
      isPasswordHidden: isPasswordHiddenParam ?? isPasswordHidden,
      isConfirmPasswordHidden:
          isConfirmPasswordHiddenParam ?? isConfirmPasswordHidden,
    );
  }

  @override
  List<Object?> get props => [
    registerState,
    gender,
    isSubmitted,
    isPasswordHidden,
    isConfirmPasswordHidden,
  ];
}
