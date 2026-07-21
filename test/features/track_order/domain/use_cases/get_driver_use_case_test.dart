import 'package:flower_app/features/track_order/domain/entities/driver_entity.dart';
import 'package:flower_app/features/track_order/domain/repositories/track_order_repo.dart';
import 'package:flower_app/features/track_order/domain/use_cases/get_driver_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_driver_use_case_test.mocks.dart';

@GenerateMocks([TrackOrderRepo])
void main() {
  late GetDriverUseCase useCase;
  late MockTrackOrderRepo mockRepo;

  setUp(() {
    mockRepo = MockTrackOrderRepo();
    useCase = GetDriverUseCase(mockRepo);
  });

  const tDriverId = 'driver_123';
  const tDriverEntity = DriverEntity(
    firstName: 'John',
    lastName: 'Doe',
    email: 'john@example.com',
    phone: '123456789',
  );

  group('GetDriverUseCase Test Group', () {
    group('Success Cases', () {
      test('should return stream of DriverEntity from repository', () {
        when(
          mockRepo.watchDriver(tDriverId),
        ).thenAnswer((_) => Stream.value(tDriverEntity));

        final result = useCase.call(tDriverId);

        expect(result, emits(tDriverEntity));
        verify(mockRepo.watchDriver(tDriverId)).called(1);
      });
    });

    group('Failure Cases', () {
      test('should emit error when repository stream fails', () {
        when(
          mockRepo.watchDriver(tDriverId),
        ).thenAnswer((_) => Stream.error('Driver Stream Error'));

        final result = useCase.call(tDriverId);

        expect(result, emitsError('Driver Stream Error'));
        verify(mockRepo.watchDriver(tDriverId)).called(1);
      });
    });
  });
}
