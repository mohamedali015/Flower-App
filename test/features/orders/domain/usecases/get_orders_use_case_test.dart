import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/config/products/domain/entities/metadata_entity.dart';
import 'package:flower_app/features/orders/domain/entities/orders_entity.dart';
import 'package:flower_app/features/orders/domain/entities/orders_response_entity.dart';
import 'package:flower_app/features/orders/domain/repositories/orders_repo.dart';
import 'package:flower_app/features/orders/domain/usecases/get_orders_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_orders_use_case_test.mocks.dart';

@GenerateMocks([OrdersRepo])
void main() {
  late MockOrdersRepo mockOrdersRepo;
  late GetOrdersUseCase useCase;
  late MetadataEntity metadata;
  late List<OrdersEntity> orders;

  setUpAll(() {
    provideDummy<Result<OrdersResponseEntity>>(
      Failure<OrdersResponseEntity>(errorMessage: ''),
    );
  });

  setUp(() {
    mockOrdersRepo = MockOrdersRepo();
    useCase = GetOrdersUseCase(mockOrdersRepo);

    metadata = const MetadataEntity(
      currentPage: 1,
      totalPages: 2,
      limit: 10,
      totalItems: 2,
    );

    orders = [
      const OrdersEntity(id: '1', isDelivered: false),
      const OrdersEntity(id: '2', isDelivered: true),
    ];
  });

  group('GetOrdersUseCase', () {
    test(
      'returns grouped active and delivered orders when repo succeeds',
      () async {
        when(mockOrdersRepo.getOrders(params: anyNamed('params'))).thenAnswer(
          (_) async => Success(
            data: OrdersResponseEntity(orders: orders, metadata: metadata),
          ),
        );

        final result = await useCase.call();

        expect(result, isA<Success>());

        final success = result as Success;
        expect(success.data.active, hasLength(1));
        expect(success.data.delivered, hasLength(1));
        expect(success.data.metadata, metadata);
        expect(success.data.active.first.id, '1');
        expect(success.data.delivered.first.id, '2');

        verify(mockOrdersRepo.getOrders(params: anyNamed('params'))).called(1);
      },
    );

    test('returns Failure when repo fails', () async {
      when(mockOrdersRepo.getOrders(params: anyNamed('params'))).thenAnswer(
        (_) async => Failure<OrdersResponseEntity>(errorMessage: 'repo error'),
      );

      final result = await useCase.call();

      expect(result, isA<Failure>());

      final failure = result as Failure;
      expect(failure.errorMessage, 'repo error');

      verify(mockOrdersRepo.getOrders(params: anyNamed('params'))).called(1);
    });
  });
}
