part of 'logout_cubit.dart';

sealed class LogoutState extends Equatable {
  const LogoutState();

  @override
  List<Object> get props => [];
}

final class LogoutInitial extends LogoutState {}

final class LogoutLoading extends LogoutState {}

final class LogoutSuccess extends LogoutState {
  final LogoutResponseEntity logoutResponseEntity;
  const LogoutSuccess({required this.logoutResponseEntity});

  @override
  List<Object> get props => [logoutResponseEntity];
}

final class LogoutFailure extends LogoutState {
  final String errorMessage;
  const LogoutFailure({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
