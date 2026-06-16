import 'package:injectable/injectable.dart';

import '../../../../config/error_handling/result.dart';
import '../entities/notifications_response_entity.dart';
import '../repositories/notifications_repo.dart';

@injectable
class GetNotificationsUseCase {
  final NotificationsRepo _repo;

  GetNotificationsUseCase(this._repo);

  Future<Result<NotificationsResponseEntity>> call() {
    return _repo.getNotifications();
  }
}
