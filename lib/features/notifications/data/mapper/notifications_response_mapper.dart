import '../../domain/entities/notifications_metadata_entity.dart';
import '../../domain/entities/notifications_response_entity.dart';
import '../model/response/notifications_response.dart';
import 'notification_mapper.dart';
import 'notifications_metadata_mapper.dart';

extension NotificationsResponseMapper on NotificationsResponse {
  NotificationsResponseEntity toEntity() {
    return NotificationsResponseEntity(
      metadata:
          metadata?.toEntity() ??
          const NotificationsMetadataEntity(
            currentPage: 1,
            totalPages: 0,
            limit: 0,
            totalItems: 0,
            unreadCount: 0,
          ),
      notifications: notifications?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}
