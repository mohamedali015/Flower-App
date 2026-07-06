import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/notifications/data/data_source/remote/notifications_remote_data_source.dart';
import 'package:flower_app/features/notifications/data/model/response/notification_model.dart';
import 'package:flower_app/features/notifications/data/model/response/notifications_metadata.dart';
import 'package:flower_app/features/notifications/data/model/response/notifications_response.dart';
import 'package:flower_app/features/notifications/data/model/response/unread_count_response.dart';
import 'package:flower_app/features/notifications/data/repositories/notifications_repo_impl.dart';
import 'package:flower_app/features/notifications/domain/entities/notifications_response_entity.dart';
import 'package:flower_app/features/notifications/domain/entities/unread_count_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'notifications_repo_impl_test.mocks.dart';

@GenerateMocks([NotificationsRemoteDataSource])
void main() {
  late NotificationsRepoImpl repoImpl;
  late MockNotificationsRemoteDataSource mockRemote;

  late NotificationsResponse notificationsResponse;
  late UnreadCountResponse unreadCountResponse;

  late String errorMessage;

  setUpAll(() {
    errorMessage = "Something went wrong";

    notificationsResponse = NotificationsResponse(
      metadata: NotificationsMetadata(
        currentPage: 1,
        totalPages: 2,
        limit: 10,
        totalItems: 20,
        unreadCount: 5,
      ),
      notifications: [
        NotificationModel(
          id: "1",
          title: "Title",
          body: "Body",
          type: "order",
          isRead: false,
          createdAt: "2025-01-01T00:00:00.000Z",
        ),
      ],
    );

    unreadCountResponse = UnreadCountResponse(unreadCount: 5);

    provideDummy<Result<NotificationsResponse>>(
      Success(data: notificationsResponse),
    );

    provideDummy<Result<UnreadCountResponse>>(
      Success(data: unreadCountResponse),
    );
  });

  setUp(() {
    mockRemote = MockNotificationsRemoteDataSource();
    repoImpl = NotificationsRepoImpl(mockRemote);
  });

  group("Get Notifications", () {
    test("success", () async {
      when(
        mockRemote.getNotifications(),
      ).thenAnswer((_) async => Success(data: notificationsResponse));

      final result = await repoImpl.getNotifications();

      expect(result, isA<Success<NotificationsResponseEntity>>());

      final data = (result as Success<NotificationsResponseEntity>).data;

      expect(data.notifications.length, 1);

      expect(
        data.notifications.first.title,
        notificationsResponse.notifications!.first.title,
      );

      expect(
        data.notifications.first.body,
        notificationsResponse.notifications!.first.body,
      );

      expect(
        data.metadata.unreadCount,
        notificationsResponse.metadata!.unreadCount,
      );

      verify(mockRemote.getNotifications()).called(1);
    });

    test("failure", () async {
      when(
        mockRemote.getNotifications(),
      ).thenAnswer((_) async => Failure(errorMessage: errorMessage));

      final result = await repoImpl.getNotifications();

      expect(result, isA<Failure<NotificationsResponseEntity>>());

      expect(
        (result as Failure<NotificationsResponseEntity>).errorMessage,
        errorMessage,
      );

      verify(mockRemote.getNotifications()).called(1);
    });
  });

  group("Get Unread Count", () {
    test("success", () async {
      when(
        mockRemote.getUnreadCount(),
      ).thenAnswer((_) async => Success(data: unreadCountResponse));

      final result = await repoImpl.getUnreadCount();

      expect(result, isA<Success<UnreadCountResponseEntity>>());

      expect(
        (result as Success<UnreadCountResponseEntity>).data.unreadCount,
        unreadCountResponse.unreadCount,
      );

      verify(mockRemote.getUnreadCount()).called(1);
    });

    test("failure", () async {
      when(
        mockRemote.getUnreadCount(),
      ).thenAnswer((_) async => Failure(errorMessage: errorMessage));

      final result = await repoImpl.getUnreadCount();

      expect(result, isA<Failure<UnreadCountResponseEntity>>());

      expect(
        (result as Failure<UnreadCountResponseEntity>).errorMessage,
        errorMessage,
      );

      verify(mockRemote.getUnreadCount()).called(1);
    });
  });
}
