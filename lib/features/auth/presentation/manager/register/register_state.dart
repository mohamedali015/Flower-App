import 'package:equatable/equatable.dart';
import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/features/auth/domain/entities/auth_entity.dart';

class RegisterState extends Equatable {
  final BaseState<AuthEntity> registerState;
  final UserGender gender;
  final bool isSubmitted;

  const RegisterState({
    BaseState<AuthEntity>? registerState,
    this.gender = UserGender.female,
    this.isSubmitted = false,
  }) : registerState = registerState ?? const BaseState();

  RegisterState copyWith({
    BaseState<AuthEntity>? registerStateParam,
    UserGender? genderParam,
    bool? isSubmittedParam,
  }) {
    return RegisterState(
      registerState: registerStateParam ?? registerState,
      gender: genderParam ?? gender,
      isSubmitted: isSubmittedParam ?? isSubmitted,
    );
  }

  @override
  List<Object?> get props => [registerState, gender, isSubmitted];
}

enum UserGender { male, female }
