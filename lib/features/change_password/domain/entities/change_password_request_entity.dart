import 'package:equatable/equatable.dart';
import 'package:flower_app/features/change_password/data/models/change_password_request.dart';

class ChangePasswordRequestEntity extends Equatable {
  final String? password;
  final String? newPassword;

  const ChangePasswordRequestEntity({this.password, this.newPassword});

  @override
  List<Object?> get props => [password, newPassword];

  ChangePasswordRequest toModel() =>
      ChangePasswordRequest(password: password, newPassword: newPassword);
}
