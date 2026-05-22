import 'package:flower_app/features/auth/domain/entities/auth_entity.dart';
import 'package:flower_app/features/edit_profile/domain/repositories/edit_profile_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/error_handling/result.dart';
import '../params/edit_profile_params.dart';

@injectable
class EditProfileUseCase {
  final EditProfileRepo _repo;

  EditProfileUseCase(this._repo);

  Future<Result<AuthEntity>> call({required EditProfileParams params}) {
    return _repo.editProfile(params: params);
  }
}
