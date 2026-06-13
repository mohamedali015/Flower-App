import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../core/values/api_end_points.dart';
import '../data/model/response/notifications_response.dart';
import '../data/model/response/unread_count_response.dart';

part 'notifications_api_client.g.dart';

@injectable
@RestApi()
abstract class NotificationsApiClient {
  @factoryMethod
  factory NotificationsApiClient(Dio dio) = _NotificationsApiClient;

  @GET(ApiEndPoints.userNotifications)
  Future<NotificationsResponse> getNotifications();

  @GET(ApiEndPoints.unreadCount)
  Future<UnreadCountResponse> getUnreadCount();
}
