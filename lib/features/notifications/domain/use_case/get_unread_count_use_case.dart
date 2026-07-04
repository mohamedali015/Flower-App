import 'package:injectable/injectable.dart';

import '../../../../config/error_handling/result.dart';
import '../entities/unread_count_response_entity.dart';
import '../repositories/notifications_repo.dart';

@injectable
class GetUnreadCountUseCase {
  final NotificationsRepo _repo;

  GetUnreadCountUseCase(this._repo);

  Future<Result<UnreadCountResponseEntity>> call() {
    return _repo.getUnreadCount();
  }
}
