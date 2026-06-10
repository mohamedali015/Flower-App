import 'package:json_annotation/json_annotation.dart';

part 'notifications_metadata.g.dart';

@JsonSerializable()
class NotificationsMetadata {
  final num? currentPage;
  final num? totalPages;
  final num? limit;
  final num? totalItems;
  final num? unreadCount;

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
