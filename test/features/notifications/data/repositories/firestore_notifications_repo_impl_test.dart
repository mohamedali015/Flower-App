import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flower_app/features/notifications/data/data_source/remote/firestore_remote_data_source.dart';
import 'package:flower_app/features/notifications/data/model/firestore_notifications_model.dart';
import 'package:flower_app/features/notifications/data/repositories/firestore_notifications_repo_impl.dart'; // Verified path
import 'package:flower_app/features/notifications/domain/entities/firestore_notification_entity.dart'; // Verified path
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'firestore_notifications_repo_impl_test.mocks.dart';

@GenerateMocks([FirestoreRemoteDataSource])
void main() {
  late FirestoreNotificationsRepoImpl repoImpl;
  late MockFirestoreRemoteDataSource mockRemoteDataSource;

  late String userId;
  late String languageCode;
  late List<FirestoreNotificationsModel> mockModelList;

  setUpAll(() {
    userId = "user_123";
    languageCode = "en";

    // Matching your actual FirestoreNotificationsModel structure
    mockModelList = [
      FirestoreNotificationsModel(
        en: NotificationContent(
          id: "1",
          title: "English Title",
          body: "English Body",
          createdAt: Timestamp.now(),
        ),
        ar: NotificationContent(
          id: "1",
          title: "العنوان بالعربي",
          body: "المحتوى بالعربي",
          createdAt: Timestamp.now(),
        ),
      ),
    ];
  });

  setUp(() {
    mockRemoteDataSource = MockFirestoreRemoteDataSource();
    repoImpl = FirestoreNotificationsRepoImpl(mockRemoteDataSource);
  });

  group("Firestore Notifications Repo Impl Test Group", () {
    test(
      "should successfully watch and map firestore notification models to entities",
      () async {
        // Arrange
        when(
          mockRemoteDataSource.watchUserNotifications(userId),
        ).thenAnswer((_) => Stream.value(mockModelList)); //

        // Act
        final streamResult = repoImpl.watchNotifications(
          userId,
          languageCode,
        ); //

        // Assert
        expect(
          streamResult,
          emits(
            isA<List<FirestoreNotificationEntity>>().having(
              (list) => list.length,
              'length',
              mockModelList.length,
            ),
          ),
        );

        verify(
          mockRemoteDataSource.watchUserNotifications(userId),
        ).called(1); //
      },
    );

    test(
      "should forward errors produced by the remote data source stream",
      () async {
        // Arrange
        final testError = Exception("Firestore connection failed");
        when(
          mockRemoteDataSource.watchUserNotifications(userId),
        ).thenAnswer((_) => Stream.error(testError));

        // Act
        final streamResult = repoImpl.watchNotifications(
          userId,
          languageCode,
        ); //

        // Assert
        expect(streamResult, emitsError(isA<Exception>()));

        verify(
          mockRemoteDataSource.watchUserNotifications(userId),
        ).called(1); //
      },
    );
  });
}
