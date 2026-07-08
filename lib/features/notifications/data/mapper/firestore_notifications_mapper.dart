import 'package:flower_app/features/notifications/data/model/firestore_notifications_model.dart';
import 'package:flower_app/features/notifications/domain/entities/firestore_notification_entity.dart';

extension FirestoreNotificationsModelMapper on FirestoreNotificationsModel {
  FirestoreNotificationEntity toEntity(String languageCode) {
    // getContentForLanguage هي الميثود اللي عملناها في الموديل
    final content = getContentForLanguage(languageCode);
    return FirestoreNotificationEntity(
      title: content?.title ?? '',
      body: content?.body ?? '',
      createdAt: content?.createdAt?.toDate(),
    );
  }
}
