import 'package:equatable/equatable.dart';

class ChangePasswordResponseEntity extends Equatable {
  final String? message;
  final String? token;

  const ChangePasswordResponseEntity({this.message, this.token});

  @override
  List<Object?> get props => [message, token];
}
