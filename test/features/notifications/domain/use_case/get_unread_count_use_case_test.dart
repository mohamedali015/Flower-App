import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/notifications/domain/entities/unread_count_response_entity.dart';
import 'package:flower_app/features/notifications/domain/repositories/notifications_repo.dart';
import 'package:flower_app/features/notifications/domain/use_case/get_unread_count_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_notifications_use_case_test.mocks.dart';

@GenerateMocks([NotificationsRepo])
void main() {
  late GetUnreadCountUseCase useCase;
  late MockNotificationsRepo mockRepo;

  late UnreadCountResponseEntity entity;
  late String errorMessage;

  setUpAll(() {
    errorMessage = "Something went wrong";

    entity = const UnreadCountResponseEntity(unreadCount: 5);

    provideDummy<Result<UnreadCountResponseEntity>>(Success(data: entity));
  });

  setUp(() {
    mockRepo = MockNotificationsRepo();
    useCase = GetUnreadCountUseCase(mockRepo);
  });

  group("Get Unread Count UseCase Test Group", () {
    test("should return success", () async {
      when(
        mockRepo.getUnreadCount(),
      ).thenAnswer((_) async => Success(data: entity));

      final result = await useCase();

      expect(result, isA<Success<UnreadCountResponseEntity>>());

      verify(mockRepo.getUnreadCount()).called(1);
    });

    test("should return failure", () async {
      when(
        mockRepo.getUnreadCount(),
      ).thenAnswer((_) async => Failure(errorMessage: errorMessage));

      final result = await useCase();

      expect(result, isA<Failure<UnreadCountResponseEntity>>());

      expect(
        (result as Failure<UnreadCountResponseEntity>).errorMessage,
        errorMessage,
      );

      verify(mockRepo.getUnreadCount()).called(1);
    });
  });
}
