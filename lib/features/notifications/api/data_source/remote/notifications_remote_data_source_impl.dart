import 'package:injectable/injectable.dart';

import '../../../../../config/error_handling/execute_api.dart';
import '../../../../../config/error_handling/result.dart';
import '../../../data/data_source/remote/notifications_remote_data_source.dart';
import '../../../data/model/response/notifications_response.dart';
import '../../../data/model/response/unread_count_response.dart';
import '../../notifications_api_client.dart';

@Injectable(as: NotificationsRemoteDataSource)
class NotificationsRemoteDataSourceImpl
    implements NotificationsRemoteDataSource {
  final NotificationsApiClient _apiClient;

  NotificationsRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Result<NotificationsResponse>> getNotifications() {
    return executeApi(() async {
      return _apiClient.getNotifications();
    });
  }

  @override
  Future<Result<UnreadCountResponse>> getUnreadCount() {
    return executeApi(() async {
      return _apiClient.getUnreadCount();
    });
  }
}
