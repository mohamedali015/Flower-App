part of 'change_password_cubit.dart';

sealed class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object> get props => [];
}

final class ChangePasswordInitial extends ChangePasswordState {}

final class ChangePasswordLoading extends ChangePasswordState {}

final class ChangePasswordSuccess extends ChangePasswordState {
  final ChangePasswordResponseEntity changePasswordResponseEntity;

  const ChangePasswordSuccess({required this.changePasswordResponseEntity});

  @override
  List<Object> get props => [changePasswordResponseEntity];
}

final class ChangePasswordError extends ChangePasswordState {
  final String errorMessage;

  const ChangePasswordError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
