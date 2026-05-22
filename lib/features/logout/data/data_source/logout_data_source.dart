import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/logout/data/models/logout_response.dart';

abstract interface class LogoutDataSource {
  Future<Result<LogoutResponse>> logout();
}
