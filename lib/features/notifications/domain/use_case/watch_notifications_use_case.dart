import 'package:flower_app/features/notifications/domain/entities/firestore_notification_entity.dart';
import 'package:flower_app/features/notifications/domain/repositories/firestore_notifications_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class WatchNotificationsUseCase {
  final FirestoreNotificationsRepo _repository;

  WatchNotificationsUseCase(this._repository);

  Stream<List<FirestoreNotificationEntity>> call(
    String userId,
    String languageCode,
  ) {
    return _repository.watchNotifications(userId, languageCode);
  }
}
