import 'package:equatable/equatable.dart';
import 'package:flower_app/features/change_password/domain/entities/change_password_request_entity.dart';

sealed class ChangePasswordEvents extends Equatable {}

class SubmitChangePasswordEvent extends ChangePasswordEvents {
  final ChangePasswordRequestEntity changePasswordRequestEntity;

  SubmitChangePasswordEvent({required this.changePasswordRequestEntity});

  @override
  List<Object?> get props => [changePasswordRequestEntity];
}
