import 'package:flower_app/features/change_password/domain/entities/change_password_request_entity.dart';
import 'package:flower_app/features/change_password/domain/entities/change_password_response_entity.dart';
import 'package:flower_app/features/change_password/domain/repositories/change_password_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/error_handling/result.dart';

@injectable
class ChangePasswordUseCase {
  final ChangePasswordRepo _repo;

  ChangePasswordUseCase(this._repo);

  Future<Result<ChangePasswordResponseEntity>> changePassword({
    required ChangePasswordRequestEntity changePasswordRequestEntity,
  }) async {
    return await _repo.changePassword(
      changePasswordRequestEntity: changePasswordRequestEntity,
    );
  }
}
