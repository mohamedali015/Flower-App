import 'package:flower_app/features/notifications/domain/entities/firestore_notification_entity.dart';
import 'package:flower_app/features/notifications/domain/repositories/firestore_notifications_repo.dart';
import 'package:flower_app/features/notifications/domain/use_case/watch_notifications_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'watch_notifications_use_case_test.mocks.dart';

@GenerateMocks([FirestoreNotificationsRepo])
void main() {
  late WatchNotificationsUseCase useCase;
  late MockFirestoreNotificationsRepo mockRepo;

  late List<FirestoreNotificationEntity> testNotificationsList;
  late String userId;
  late String languageCode;

  setUpAll(() {
    userId = "user_123";
    languageCode = "en";

    // Initialize an empty or mock list matching your FirestoreNotificationEntity structure
    testNotificationsList = [];
  });

  setUp(() {
    mockRepo = MockFirestoreNotificationsRepo();
    useCase = WatchNotificationsUseCase(mockRepo);
  });

  group("Watch Notifications UseCase Test Group", () {
    test("should emit stream of notifications successfully", () async {
      // Arrange
      when(
        mockRepo.watchNotifications(userId, languageCode),
      ).thenAnswer((_) => Stream.value(testNotificationsList));

      // Act
      final streamResult = useCase(userId, languageCode);

      // Assert
      expect(streamResult, emits(testNotificationsList));

      verify(mockRepo.watchNotifications(userId, languageCode)).called(1);
    });

    test("should forward error when stream encounters an issue", () async {
      // Arrange
      final testError = Exception("Database error");
      when(
        mockRepo.watchNotifications(userId, languageCode),
      ).thenAnswer((_) => Stream.error(testError));

      // Act
      final streamResult = useCase(userId, languageCode);

      // Assert
      expect(streamResult, emitsError(isA<Exception>()));

      verify(mockRepo.watchNotifications(userId, languageCode)).called(1);
    });
  });
}
