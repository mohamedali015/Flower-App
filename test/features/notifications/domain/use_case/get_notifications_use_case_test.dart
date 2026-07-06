import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/notifications/domain/entities/notifications_metadata_entity.dart';
import 'package:flower_app/features/notifications/domain/entities/notifications_response_entity.dart';
import 'package:flower_app/features/notifications/domain/repositories/notifications_repo.dart';
import 'package:flower_app/features/notifications/domain/use_case/get_notifications_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_notifications_use_case_test.mocks.dart';

@GenerateMocks([NotificationsRepo])
void main() {
  late GetNotificationsUseCase useCase;
  late MockNotificationsRepo mockRepo;

  late NotificationsResponseEntity entity;
  late String errorMessage;

  setUpAll(() {
    errorMessage = "Something went wrong";

    entity = const NotificationsResponseEntity(
      metadata: NotificationsMetadataEntity(
        currentPage: 1,
        totalPages: 1,
        limit: 10,
        totalItems: 1,
        unreadCount: 0,
      ),
      notifications: [],
    );

    provideDummy<Result<NotificationsResponseEntity>>(Success(data: entity));
  });

  setUp(() {
    mockRepo = MockNotificationsRepo();
    useCase = GetNotificationsUseCase(mockRepo);
  });

  group("Get Notifications UseCase Test Group", () {
    test("should return success", () async {
      when(
        mockRepo.getNotifications(),
      ).thenAnswer((_) async => Success(data: entity));

      final result = await useCase();

      expect(result, isA<Success<NotificationsResponseEntity>>());

      verify(mockRepo.getNotifications()).called(1);
    });

    test("should return failure", () async {
      when(
        mockRepo.getNotifications(),
      ).thenAnswer((_) async => Failure(errorMessage: errorMessage));

      final result = await useCase();

      expect(result, isA<Failure<NotificationsResponseEntity>>());

      expect(
        (result as Failure<NotificationsResponseEntity>).errorMessage,
        errorMessage,
      );

      verify(mockRepo.getNotifications()).called(1);
    });
  });
}
