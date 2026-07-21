import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/track_order/domain/repositories/track_order_repo.dart';
import 'package:flower_app/features/track_order/domain/use_cases/update_order_to_completed_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'update_order_to_completed_use_case_test.mocks.dart';

@GenerateMocks([TrackOrderRepo])
void main() {
  late UpdateOrderToCompletedUseCase useCase;
  late MockTrackOrderRepo mockRepo;

  setUpAll(() {
    provideDummy<Result<void>>(Success(data: null));
  });

  setUp(() {
    mockRepo = MockTrackOrderRepo();
    useCase = UpdateOrderToCompletedUseCase(mockRepo);
  });

  const tOrderId = '123';

  group('UpdateOrderToCompletedUseCase Test Group', () {
    group('Success Cases', () {
      test('should return Success<void> from repository', () async {
        when(
          mockRepo.updateOrderToCompleted(tOrderId),
        ).thenAnswer((_) async => Success(data: null));

        final result = await useCase.call(tOrderId);

        expect(result, isA<Success<void>>());
        verify(mockRepo.updateOrderToCompleted(tOrderId)).called(1);
      });
    });

    group('Failure Cases', () {
      test('should return Failure from repository', () async {
        when(
          mockRepo.updateOrderToCompleted(tOrderId),
        ).thenAnswer((_) async => Failure(errorMessage: 'Update Error'));

        final result = await useCase.call(tOrderId);

        expect(result, isA<Failure<void>>());
        expect((result as Failure).errorMessage, 'Update Error');
        verify(mockRepo.updateOrderToCompleted(tOrderId)).called(1);
      });
    });
  });
}
