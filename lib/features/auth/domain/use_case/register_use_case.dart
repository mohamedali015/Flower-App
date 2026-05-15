import 'package:injectable/injectable.dart';

import '../../../../config/error_handling/result.dart';
import '../entities/auth_entity.dart';
import '../params/register_params.dart';
import '../repositories/auth_repo.dart';

@injectable
class RegisterUseCase {
  final AuthRepo _authRepo;

  RegisterUseCase(this._authRepo);

  Future<Result<AuthEntity>> call({required RegisterParams params}) async {
    return _authRepo.register(params: params);
  }
}
