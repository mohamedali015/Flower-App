import 'package:json_annotation/json_annotation.dart';

import 'notification_model.dart';
import 'notifications_metadata.dart';

part 'notifications_response.g.dart';

@JsonSerializable()
class NotificationsResponse {
  final String? message;

  final NotificationsMetadata? metadata;

  final List<NotificationModel>? notifications;

  NotificationsResponse({this.message, this.metadata, this.notifications});

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationsResponseFromJson(json);
}
