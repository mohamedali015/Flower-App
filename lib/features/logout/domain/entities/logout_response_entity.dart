import 'package:equatable/equatable.dart';

class LogoutResponseEntity extends Equatable {
  final String message;

  const LogoutResponseEntity({required this.message});

  @override
  List<Object> get props => [message];
}
