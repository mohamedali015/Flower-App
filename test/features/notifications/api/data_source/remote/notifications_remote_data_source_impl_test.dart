import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/notifications/api/data_source/remote/notifications_remote_data_source_impl.dart';
import 'package:flower_app/features/notifications/api/notifications_api_client.dart';
import 'package:flower_app/features/notifications/data/model/response/notification_model.dart';
import 'package:flower_app/features/notifications/data/model/response/notifications_metadata.dart';
import 'package:flower_app/features/notifications/data/model/response/notifications_response.dart';
import 'package:flower_app/features/notifications/data/model/response/unread_count_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'notifications_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([NotificationsApiClient])
void main() {
  late NotificationsRemoteDataSourceImpl remoteDataSourceImpl;

  late MockNotificationsApiClient mockApiClient;

  late NotificationsResponse notificationsResponse;

  late UnreadCountResponse unreadCountResponse;

  setUpAll(() {
    notificationsResponse = NotificationsResponse(
      message: "success",
      metadata: NotificationsMetadata(
        currentPage: 1,
        totalPages: 1,
        limit: 10,
        totalItems: 1,
        unreadCount: 1,
      ),
      notifications: [
        NotificationModel(
          id: "1",
          title: "title",
          body: "body",
          type: "order",
          isRead: false,
          createdAt: "2025-01-01T00:00:00.000Z",
        ),
      ],
    );

    unreadCountResponse = UnreadCountResponse(
      message: "success",
      unreadCount: 5,
    );
  });

  setUp(() {
    mockApiClient = MockNotificationsApiClient();

    remoteDataSourceImpl = NotificationsRemoteDataSourceImpl(mockApiClient);
  });

  group("Get Notifications Tests", () {
    test("should return success when api succeeds", () async {
      when(
        mockApiClient.getNotifications(),
      ).thenAnswer((_) async => notificationsResponse);

      final result = await remoteDataSourceImpl.getNotifications();

      expect(result, isA<Success<NotificationsResponse>>());

      expect(
        (result as Success<NotificationsResponse>).data,
        notificationsResponse,
      );

      verify(mockApiClient.getNotifications()).called(1);

      verifyNoMoreInteractions(mockApiClient);
    });

    test("should return failure when api throws exception", () async {
      when(mockApiClient.getNotifications()).thenThrow(Exception());

      final result = await remoteDataSourceImpl.getNotifications();

      expect(result, isA<Failure<NotificationsResponse>>());

      verify(mockApiClient.getNotifications()).called(1);

      verifyNoMoreInteractions(mockApiClient);
    });
  });

  group("Get Unread Count Tests", () {
    test("should return success when api succeeds", () async {
      when(
        mockApiClient.getUnreadCount(),
      ).thenAnswer((_) async => unreadCountResponse);

      final result = await remoteDataSourceImpl.getUnreadCount();

      expect(result, isA<Success<UnreadCountResponse>>());

      expect(
        (result as Success<UnreadCountResponse>).data,
        unreadCountResponse,
      );

      verify(mockApiClient.getUnreadCount()).called(1);

      verifyNoMoreInteractions(mockApiClient);
    });

    test("should return failure when api throws exception", () async {
      when(mockApiClient.getUnreadCount()).thenThrow(Exception());

      final result = await remoteDataSourceImpl.getUnreadCount();

      expect(result, isA<Failure<UnreadCountResponse>>());

      verify(mockApiClient.getUnreadCount()).called(1);

      verifyNoMoreInteractions(mockApiClient);
    });
  });
}
