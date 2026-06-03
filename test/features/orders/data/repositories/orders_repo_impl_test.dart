import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/config/products/data/model/response/metadata_model.dart';
import 'package:flower_app/features/orders/data/data_source/orders_remote_data_source.dart';
import 'package:flower_app/features/orders/data/models/orders.dart';
import 'package:flower_app/features/orders/data/models/orders_dto.dart';
import 'package:flower_app/features/orders/data/params/orders_query_params.dart';
import 'package:flower_app/features/orders/data/repositories/orders_repo_impl.dart';
import 'package:flower_app/features/orders/domain/entities/orders_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'orders_repo_impl_test.mocks.dart';

@GenerateMocks([OrdersRemoteDataSource])
void main() {
  late OrdersRepoImpl ordersRepoImpl;
  late MockOrdersRemoteDataSource mockOrdersRemoteDataSource;
  late OrdersDto responseDto;
  late OrdersQueryParams queryParams;

  setUpAll(() {
    provideDummy<Result<OrdersDto>>(Failure<OrdersDto>(errorMessage: ''));
  });

  setUp(() {
    mockOrdersRemoteDataSource = MockOrdersRemoteDataSource();
    ordersRepoImpl = OrdersRepoImpl(mockOrdersRemoteDataSource);

    queryParams = const OrdersQueryParams(page: 1, limit: 10);

    responseDto = OrdersDto(
      metadata: MetadataModel(
        currentPage: 1,
        totalPages: 2,
        limit: 10,
        totalItems: 12,
      ),
      orders: [Orders(Id: 'order_1')],
    );
  });

  group('OrdersRepoImpl', () {
    test(
      'returns Success<OrdersResponseEntity> when remote source succeeds',
      () async {
        when(
          mockOrdersRemoteDataSource.getOrders(params: anyNamed('params')),
        ).thenAnswer((_) async => Success(data: responseDto));

        final result = await ordersRepoImpl.getOrders(params: queryParams);

        expect(result, isA<Success<OrdersResponseEntity>>());

        final success = result as Success<OrdersResponseEntity>;
        expect(success.data.orders, hasLength(1));
        expect(success.data.orders.first.id, 'order_1');
        expect(success.data.metadata.currentPage, 1);
        expect(success.data.metadata.totalPages, 2);

        verify(
          mockOrdersRemoteDataSource.getOrders(params: anyNamed('params')),
        ).called(1);
      },
    );

    test(
      'returns Failure<OrdersResponseEntity> when remote source fails',
      () async {
        when(
          mockOrdersRemoteDataSource.getOrders(params: anyNamed('params')),
        ).thenAnswer((_) async => Failure<OrdersDto>(errorMessage: 'error'));

        final result = await ordersRepoImpl.getOrders(params: queryParams);

        expect(result, isA<Failure<OrdersResponseEntity>>());

        final failure = result as Failure<OrdersResponseEntity>;
        expect(failure.errorMessage, 'error');

        verify(
          mockOrdersRemoteDataSource.getOrders(params: anyNamed('params')),
        ).called(1);
      },
    );
  });
}
