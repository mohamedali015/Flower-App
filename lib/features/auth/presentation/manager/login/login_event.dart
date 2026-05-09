sealed class LoginEvents {}

class LoginSubmitEvent extends LoginEvents {
  final String email;
  final String password;
  final bool rememberMe;

  LoginSubmitEvent({
    required this.email,
    required this.password,
    required this.rememberMe,
  });
}

class LoginRememberMeChangedEvent extends LoginEvents {
  final bool rememberMe;

  LoginRememberMeChangedEvent({required this.rememberMe});
}
