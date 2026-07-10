import '../../domain/entities/notifications_metadata_entity.dart';
import '../model/response/notifications_metadata.dart';

extension NotificationsMetadataMapper on NotificationsMetadata {
  NotificationsMetadataEntity toEntity() {
    return NotificationsMetadataEntity(
      currentPage: currentPage ?? 1,
      totalPages: totalPages ?? 0,
      limit: limit ?? 0,
      totalItems: totalItems ?? 0,
      unreadCount: unreadCount ?? 0,
    );
  }
}
