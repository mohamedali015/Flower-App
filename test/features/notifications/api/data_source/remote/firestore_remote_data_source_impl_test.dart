import 'package:flower_app/config/data_base/data_base_service.dart';
import 'package:flower_app/config/firebase/firestore_collection.dart';
import 'package:flower_app/features/notifications/api/data_source/remote/firestore_remote_data_source_impl.dart';
import 'package:flower_app/features/notifications/data/model/firestore_notifications_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'firestore_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([DatabaseService])
void main() {
  late FirestoreRemoteDataSourceImpl remoteDataSourceImpl;
  late MockDatabaseService mockDatabaseService;

  late String userId;
  late String expectedPath;
  late List<FirestoreNotificationsModel> mockNotificationsList;

  setUpAll(() {
    userId = "user_123";
    expectedPath =
        "${FireStoreCollection.usersCollectionPath}/$userId/${FireStoreCollection.notificationsCollectionPath}";

    mockNotificationsList = [
      FirestoreNotificationsModel(
        // Set up any required properties here to match your model
      ),
    ];
  });

  setUp(() {
    mockDatabaseService = MockDatabaseService();
    remoteDataSourceImpl = FirestoreRemoteDataSourceImpl(mockDatabaseService);
  });

  group("Watch User Notifications Tests", () {
    test(
      "should return stream of notifications list when database service succeeds",
      () async {
        // Arrange
        when(
          mockDatabaseService.watchCollection<FirestoreNotificationsModel>(
            path: expectedPath,
            fromFirestore: anyNamed('fromFirestore'),
          ),
        ).thenAnswer((_) => Stream.value(mockNotificationsList));

        // Act
        final streamResult = remoteDataSourceImpl.watchUserNotifications(
          userId,
        );

        // Assert
        expect(streamResult, emits(mockNotificationsList));

        verify(
          mockDatabaseService.watchCollection<FirestoreNotificationsModel>(
            path: expectedPath,
            fromFirestore: anyNamed('fromFirestore'),
          ),
        ).called(1);

        verifyNoMoreInteractions(mockDatabaseService);
      },
    );

    test(
      "should forward stream error when database service throws or emits an error",
      () async {
        // Arrange
        final testError = Exception("Database subscription failed");
        when(
          mockDatabaseService.watchCollection<FirestoreNotificationsModel>(
            path: expectedPath,
            fromFirestore: anyNamed('fromFirestore'),
          ),
        ).thenAnswer((_) => Stream.error(testError));

        // Act
        final streamResult = remoteDataSourceImpl.watchUserNotifications(
          userId,
        );

        // Assert
        expect(streamResult, emitsError(isA<Exception>()));

        verify(
          mockDatabaseService.watchCollection<FirestoreNotificationsModel>(
            path: expectedPath,
            fromFirestore: anyNamed('fromFirestore'),
          ),
        ).called(1);

        verifyNoMoreInteractions(mockDatabaseService);
      },
    );
  });
}
