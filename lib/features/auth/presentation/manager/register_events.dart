import 'package:flower_app/features/auth/presentation/pages/register/register_screen.dart';

sealed class RegisterEvents {}

class SubmitRegisterEvent extends RegisterEvents {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String confirmPassword;
  final String phone;
  final String gender;

  SubmitRegisterEvent({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.phone,
    required this.gender,
  });
}

class SelectGenderEvent extends RegisterEvents {
  final UserGender gender;

  SelectGenderEvent({required this.gender});
}

class SubmitPressedEvent extends RegisterEvents {}

class PasswordVisibilityEvent extends RegisterEvents {}

class ConfirmPasswordVisibilityEvent extends RegisterEvents {}
