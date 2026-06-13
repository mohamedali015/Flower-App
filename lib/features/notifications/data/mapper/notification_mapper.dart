import '../../domain/entities/notification_entity.dart';
import '../model/response/notification_model.dart';

extension NotificationMapper on NotificationModel {
  NotificationEntity toEntity() {
    return NotificationEntity(
      id: id ?? '',
      title: title ?? '',
      body: body ?? '',
      type: type ?? '',
      isRead: isRead ?? false,
      createdAt:
          DateTime.tryParse(createdAt ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
    );
  }
}
