import '../../domain/entities/unread_count_response_entity.dart';
import '../model/response/unread_count_response.dart';

extension UnreadCountResponseMapper on UnreadCountResponse {
  UnreadCountResponseEntity toEntity() {
    return UnreadCountResponseEntity(unreadCount: unreadCount ?? 0);
  }
}
