import '../../../../../config/error_handling/result.dart';
import '../../model/response/notifications_response.dart';
import '../../model/response/unread_count_response.dart';

abstract class NotificationsRemoteDataSource {
  Future<Result<NotificationsResponse>> getNotifications();

  Future<Result<UnreadCountResponse>> getUnreadCount();
}
