import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/notifications/domain/entities/notification_entity.dart';
import 'package:flower_app/features/notifications/domain/entities/notifications_metadata_entity.dart';
import 'package:flower_app/features/notifications/domain/entities/notifications_response_entity.dart';
import 'package:flower_app/features/notifications/domain/entities/unread_count_response_entity.dart';
import 'package:flower_app/features/notifications/domain/use_case/get_notifications_use_case.dart';
import 'package:flower_app/features/notifications/domain/use_case/get_unread_count_use_case.dart';
import 'package:flower_app/features/notifications/presentation/manager/notifications_cubit.dart';
import 'package:flower_app/features/notifications/presentation/manager/notifications_events.dart';
import 'package:flower_app/features/notifications/presentation/manager/notifications_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'notifications_cubit_test.mocks.dart';

@GenerateMocks([GetNotificationsUseCase, GetUnreadCountUseCase])
void main() {
  late NotificationsCubit cubit;

  late MockGetNotificationsUseCase mockGetNotificationsUseCase;
  late MockGetUnreadCountUseCase mockGetUnreadCountUseCase;

  late NotificationsResponseEntity notificationsEntity;
  late UnreadCountResponseEntity unreadEntity;

  late String errorMessage;

  setUpAll(() {
    errorMessage = "Something went wrong";

    notificationsEntity = NotificationsResponseEntity(
      metadata: const NotificationsMetadataEntity(
        currentPage: 1,
        totalPages: 1,
        limit: 10,
        totalItems: 1,
        unreadCount: 1,
      ),
      notifications: [
        NotificationEntity(
          id: "1",
          title: "title",
          body: "body",
          type: "order",
          isRead: false,
          createdAt: DateTime(2025),
        ),
      ],
    );

    unreadEntity = const UnreadCountResponseEntity(unreadCount: 5);

    provideDummy<Result<NotificationsResponseEntity>>(
      Success(data: notificationsEntity),
    );

    provideDummy<Result<UnreadCountResponseEntity>>(
      Success(data: unreadEntity),
    );
  });

  setUp(() {
    mockGetNotificationsUseCase = MockGetNotificationsUseCase();

    mockGetUnreadCountUseCase = MockGetUnreadCountUseCase();

    cubit = NotificationsCubit(
      mockGetNotificationsUseCase,
      mockGetUnreadCountUseCase,
    );
  });

  blocTest<NotificationsCubit, NotificationsState>(
    "notifications success",

    setUp: () {
      when(
        mockGetNotificationsUseCase(),
      ).thenAnswer((_) async => Success(data: notificationsEntity));
    },

    build: () => cubit,

    act: (cubit) {
      cubit.doEvent(GetNotificationsEvent());
    },

    expect: () => [isA<NotificationsState>(), isA<NotificationsState>()],

    verify: (_) {
      verify(mockGetNotificationsUseCase()).called(1);
    },
  );

  blocTest<NotificationsCubit, NotificationsState>(
    "notifications failure",

    setUp: () {
      when(
        mockGetNotificationsUseCase(),
      ).thenAnswer((_) async => Failure(errorMessage: errorMessage));
    },

    build: () => cubit,

    act: (cubit) {
      cubit.doEvent(GetNotificationsEvent());
    },

    expect: () => [isA<NotificationsState>(), isA<NotificationsState>()],

    verify: (_) {
      verify(mockGetNotificationsUseCase()).called(1);
    },
  );

  blocTest<NotificationsCubit, NotificationsState>(
    "unread count success",

    setUp: () {
      when(
        mockGetUnreadCountUseCase(),
      ).thenAnswer((_) async => Success(data: unreadEntity));
    },

    build: () => cubit,

    act: (cubit) {
      cubit.doEvent(GetUnreadCountEvent());
    },

    expect: () => [isA<NotificationsState>(), isA<NotificationsState>()],

    verify: (_) {
      verify(mockGetUnreadCountUseCase()).called(1);
    },
  );

  blocTest<NotificationsCubit, NotificationsState>(
    "unread count failure",

    setUp: () {
      when(
        mockGetUnreadCountUseCase(),
      ).thenAnswer((_) async => Failure(errorMessage: errorMessage));
    },

    build: () => cubit,

    act: (cubit) {
      cubit.doEvent(GetUnreadCountEvent());
    },

    expect: () => [isA<NotificationsState>(), isA<NotificationsState>()],

    verify: (_) {
      verify(mockGetUnreadCountUseCase()).called(1);
    },
  );
}
