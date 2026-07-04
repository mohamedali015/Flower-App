import 'package:injectable/injectable.dart';

import '../../../../config/error_handling/result.dart';
import '../../domain/entities/notifications_response_entity.dart';
import '../../domain/entities/unread_count_response_entity.dart';
import '../../domain/repositories/notifications_repo.dart';
import '../data_source/remote/notifications_remote_data_source.dart';
import '../mapper/notifications_response_mapper.dart';
import '../mapper/unread_count_response_mapper.dart';
import '../model/response/notifications_response.dart';
import '../model/response/unread_count_response.dart';

@Injectable(as: NotificationsRepo)
class NotificationsRepoImpl implements NotificationsRepo {
  final NotificationsRemoteDataSource _remoteDataSource;

  NotificationsRepoImpl(this._remoteDataSource);

  @override
  Future<Result<NotificationsResponseEntity>> getNotifications() async {
    final response = await _remoteDataSource.getNotifications();

    switch (response) {
      case Success<NotificationsResponse>():
        return Success(data: response.data.toEntity());

      case Failure<NotificationsResponse>():
        return Failure(errorMessage: response.errorMessage);
    }
  }

  @override
  Future<Result<UnreadCountResponseEntity>> getUnreadCount() async {
    final response = await _remoteDataSource.getUnreadCount();

    switch (response) {
      case Success<UnreadCountResponse>():
        return Success(data: response.data.toEntity());

      case Failure<UnreadCountResponse>():
        return Failure(errorMessage: response.errorMessage);
    }
  }
}
