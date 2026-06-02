import 'package:json_annotation/json_annotation.dart';

part 'notifications_metadata.g.dart';

@JsonSerializable()
class NotificationsMetadata {
  final int? currentPage;
  final int? totalPages;
  final int? limit;
  final int? totalItems;
  final int? unreadCount;

  NotificationsMetadata({
    this.currentPage,
    this.totalPages,
    this.limit,
    this.totalItems,
    this.unreadCount,
  });

  factory NotificationsMetadata.fromJson(Map<String, dynamic> json) =>
      _$NotificationsMetadataFromJson(json);
}
