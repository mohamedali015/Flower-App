import 'package:flower_app/features/notifications/domain/entities/firestore_notification_entity.dart';

abstract class FirestoreNotificationsRepo {
  Stream<List<FirestoreNotificationEntity>> watchNotifications(
    String userId,
    String languageCode,
  );
}
