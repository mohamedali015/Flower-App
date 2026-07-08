import 'package:flower_app/features/notifications/data/model/firestore_notifications_model.dart';

abstract class FirestoreRemoteDataSource {
  Stream<List<FirestoreNotificationsModel>> watchUserNotifications(
    String userId,
  );
}
