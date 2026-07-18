sealed class NotificationsEvents {}

class GetNotificationsEvent extends NotificationsEvents {}

class GetFiretoreNotificationsEvent extends NotificationsEvents {
  final String userId;
  final String languageCode;

  GetFiretoreNotificationsEvent({
    required this.userId,
    required this.languageCode,
  });
}

class GetUnreadCountEvent extends NotificationsEvents {}
