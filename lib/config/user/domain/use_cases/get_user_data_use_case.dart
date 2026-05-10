import 'package:injectable/injectable.dart';
import '../../../../features/auth/domain/entities/user_entity.dart';
import '../../../error_handling/result.dart';
import '../repositories/user_repo.dart';

@injectable
class GetUserDataUseCase {
  final UserRepo _repo;

  const GetUserDataUseCase(this._repo);

  Future<Result<UserEntity>> call() {
    return _repo.getUserData();
  }
}
