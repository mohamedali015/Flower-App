import 'package:equatable/equatable.dart';

import 'notification_entity.dart';
import 'notifications_metadata_entity.dart';

class NotificationsResponseEntity extends Equatable {
  final NotificationsMetadataEntity metadata;
  final List<NotificationEntity> notifications;

  const NotificationsResponseEntity({
    required this.metadata,
    required this.notifications,
  });

  @override
  List<Object> get props => [metadata, notifications];
}
