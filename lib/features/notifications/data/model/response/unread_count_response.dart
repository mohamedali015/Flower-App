import 'package:json_annotation/json_annotation.dart';

part 'unread_count_response.g.dart';

@JsonSerializable()
class UnreadCountResponse {
  final String? message;

  final int? unreadCount;

  UnreadCountResponse({this.message, this.unreadCount});

  factory UnreadCountResponse.fromJson(Map<String, dynamic> json) =>
      _$UnreadCountResponseFromJson(json);
}
