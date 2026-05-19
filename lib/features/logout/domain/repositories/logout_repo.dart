import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/logout/domain/entities/logout_response_entity.dart';

abstract interface class LogoutRepo {
  Future<Result<LogoutResponseEntity>> logout();
}
