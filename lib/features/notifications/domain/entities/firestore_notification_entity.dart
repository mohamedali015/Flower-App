class FirestoreNotificationEntity {
  final String title;
  final String body;
  final DateTime? createdAt;

  FirestoreNotificationEntity({
    required this.title,
    required this.body,
    this.createdAt,
  });
}
