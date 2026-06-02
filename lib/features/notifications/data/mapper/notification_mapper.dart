import '../../domain/entities/notification_entity.dart';
import '../model/response/notification_model.dart';

extension NotificationMapper on NotificationModel {
  NotificationEntity toEntity() {
    return const NotificationEntity();
  }
}
