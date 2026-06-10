import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel {
  final String? id;
  final String? title;
  final String? body;
  final String? type;
  final bool? isRead;
  final String? createdAt;

  NotificationModel({
    this.id,
    this.title,
    this.body,
    this.type,
    this.isRead,
    this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
}
