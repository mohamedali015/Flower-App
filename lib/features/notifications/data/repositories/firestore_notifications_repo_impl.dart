import 'package:flower_app/features/notifications/data/data_source/remote/firestore_remote_data_source.dart';
import 'package:flower_app/features/notifications/data/mapper/firestore_notifications_mapper.dart';
import 'package:flower_app/features/notifications/domain/entities/firestore_notification_entity.dart';
import 'package:flower_app/features/notifications/domain/repositories/firestore_notifications_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: FirestoreNotificationsRepo)
class FirestoreNotificationsRepoImpl implements FirestoreNotificationsRepo {
  final FirestoreRemoteDataSource _remoteDataSource;

  FirestoreNotificationsRepoImpl(this._remoteDataSource);

  @override
  Stream<List<FirestoreNotificationEntity>> watchNotifications(
    String userId,
    String languageCode,
  ) {
    return _remoteDataSource.watchUserNotifications(userId).map((modelsList) {
      return modelsList.map((model) => model.toEntity(languageCode)).toList();
    });
  }
}
