import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/logout/domain/entities/logout_response_entity.dart';
import 'package:flower_app/features/logout/domain/repositories/logout_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class LogoutUseCase {
  final LogoutRepo _logoutRepo;

  LogoutUseCase(this._logoutRepo);

  Future<Result<LogoutResponseEntity>> call() {
    return _logoutRepo.logout();
  }
}
