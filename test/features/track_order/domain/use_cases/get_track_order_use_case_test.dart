import 'package:flower_app/features/track_order/domain/entities/track_order_entity.dart';
import 'package:flower_app/features/track_order/domain/repositories/track_order_repo.dart';
import 'package:flower_app/features/track_order/domain/use_cases/get_track_order_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_track_order_use_case_test.mocks.dart';

@GenerateMocks([TrackOrderRepo])
void main() {
  late GetTrackOrderUseCase useCase;
  late MockTrackOrderRepo mockRepo;

  setUp(() {
    mockRepo = MockTrackOrderRepo();
    useCase = GetTrackOrderUseCase(mockRepo);
  });

  const tOrderId = '123';
  const tTrackOrderEntity = TrackOrderEntity(
    id: tOrderId,
    orderNumber: 'ORD-1',
    orderStatus: 'pending',
    isActive: true,
    driverId: 'd1',
    totalPrice: 100,
    paymentType: 'cash',
    isPaid: false,
    isDelivered: false,
    state: '',
    createdAt: '',
    updatedAt: '',
    paidAt: '',
    v: 0,
    user: TrackOrderUserEntity(
      id: '',
      firstName: '',
      lastName: '',
      email: '',
      phone: '',
      photo: '',
    ),
    store: TrackOrderStoreEntity(
      name: '',
      image: '',
      phoneNumber: '',
      address: '',
      latLong: '',
    ),
    shippingAddress: TrackOrderShippingAddressEntity(
      street: '',
      city: '',
      phone: '',
      lat: '',
      long: '',
    ),
    orderItems: [],
    currentLocation: TrackOrderCurrentLocationEntity(latitude: 0, longitude: 0),
  );

  group('GetTrackOrderUseCase Test Group', () {
    group('Success Cases', () {
      test('should return stream of TrackOrderEntity from repository', () {
        when(
          mockRepo.watchOrder(tOrderId),
        ).thenAnswer((_) => Stream.value(tTrackOrderEntity));

        final result = useCase.call(tOrderId);

        expect(result, emits(tTrackOrderEntity));
        verify(mockRepo.watchOrder(tOrderId)).called(1);
      });
    });

    group('Failure Cases', () {
      test('should emit error when repository stream fails', () {
        when(
          mockRepo.watchOrder(tOrderId),
        ).thenAnswer((_) => Stream.error('Stream Error'));

        final result = useCase.call(tOrderId);

        expect(result, emitsError('Stream Error'));
        verify(mockRepo.watchOrder(tOrderId)).called(1);
      });
    });
  });
}
