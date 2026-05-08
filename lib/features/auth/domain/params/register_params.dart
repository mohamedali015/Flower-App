class RegisterParams {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String confirmPassword;
  final String phone;
  final String gender;

  const RegisterParams({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.phone,
    required this.gender,
  });
}
