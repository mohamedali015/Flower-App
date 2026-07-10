import '../../../../config/error_handling/result.dart';
import '../entities/notifications_response_entity.dart';
import '../entities/unread_count_response_entity.dart';

abstract interface class NotificationsRepo {
  Future<Result<NotificationsResponseEntity>> getNotifications();

  Future<Result<UnreadCountResponseEntity>> getUnreadCount();
}
