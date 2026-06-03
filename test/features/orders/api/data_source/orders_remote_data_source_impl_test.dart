import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/config/products/data/model/response/metadata_model.dart';
import 'package:flower_app/features/orders/api/orders_api_client.dart';
import 'package:flower_app/features/orders/api/data_source/orders_remote_data_source_impl.dart';
import 'package:flower_app/features/orders/data/models/orders.dart';
import 'package:flower_app/features/orders/data/models/orders_dto.dart';
import 'package:flower_app/features/orders/data/params/orders_query_params.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'orders_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([OrdersApiClient])
void main() {
  late MockOrdersApiClient mockOrdersApiClient;
  late OrdersRemoteDataSourceImpl dataSource;
  late OrdersDto responseDto;
  late OrdersQueryParams params;

  setUp(() {
    mockOrdersApiClient = MockOrdersApiClient();
    dataSource = OrdersRemoteDataSourceImpl(mockOrdersApiClient);
    params = const OrdersQueryParams(page: 2, limit: 10);
    responseDto = OrdersDto(
      metadata: MetadataModel(
        currentPage: 2,
        totalPages: 5,
        limit: 10,
        totalItems: 50,
      ),
      orders: [Orders(Id: 'order_1')],
    );
  });

  group('OrdersRemoteDataSourceImpl', () {
    test('returns Success<OrdersDto> when API client succeeds', () async {
      when(
        mockOrdersApiClient.getOrders(queryParams: anyNamed('queryParams')),
      ).thenAnswer((_) async => responseDto);

      final result = await dataSource.getOrders(params: params);

      expect(result, isA<Success<OrdersDto>>());

      final success = result as Success<OrdersDto>;
      expect(
        success.data.metadata?.currentPage,
        responseDto.metadata?.currentPage,
      );
      expect(success.data.orders?.first.Id, responseDto.orders?.first.Id);

      verify(
        mockOrdersApiClient.getOrders(queryParams: anyNamed('queryParams')),
      ).called(1);
    });

    test('forwards query params to OrdersApiClient', () async {
      when(
        mockOrdersApiClient.getOrders(queryParams: anyNamed('queryParams')),
      ).thenAnswer((_) async => responseDto);

      await dataSource.getOrders(params: params);

      final captured = verify(
        mockOrdersApiClient.getOrders(
          queryParams: captureAnyNamed('queryParams'),
        ),
      ).captured;

      expect(captured, hasLength(1));
      expect(captured.first, {'page': 2, 'limit': 10});
    });

    test('returns Failure<OrdersDto> when API client throws', () async {
      when(
        mockOrdersApiClient.getOrders(queryParams: anyNamed('queryParams')),
      ).thenThrow(Exception('Network error'));

      final result = await dataSource.getOrders(params: params);

      expect(result, isA<Failure<OrdersDto>>());

      final failure = result as Failure<OrdersDto>;
      expect(failure.errorMessage, isNotNull);

      verify(
        mockOrdersApiClient.getOrders(queryParams: anyNamed('queryParams')),
      ).called(1);
    });
  });
}
