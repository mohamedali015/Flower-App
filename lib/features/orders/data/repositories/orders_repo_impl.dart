import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/config/products/domain/entities/metadata_entity.dart';
import 'package:flower_app/features/orders/data/data_source/orders_remote_data_source.dart';
import 'package:flower_app/features/orders/data/mapper/orders_mapper.dart';
import 'package:flower_app/features/orders/data/models/orders_dto.dart';
import 'package:flower_app/features/orders/data/params/orders_query_params.dart';
import 'package:flower_app/features/orders/domain/entities/orders_response_entity.dart';
import 'package:flower_app/features/orders/domain/repositories/orders_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OrdersRepo)
class OrdersRepoImpl implements OrdersRepo {
  final OrdersRemoteDataSource remoteDataSource;

  OrdersRepoImpl(this.remoteDataSource);
  @override
  Future<Result<OrdersResponseEntity>> getOrders({
    OrdersQueryParams? params,
  }) async {
    final response = await remoteDataSource.getOrders(params: params);

    switch (response) {
      case Success<OrdersDto>():
        {
          final orders =
              response.data.orders
                  ?.map((orderDto) => orderDto.toEntity())
                  .toList() ??
              [];
          final metadata = MetadataEntity(
            currentPage: response.data.metadata?.currentPage ?? 1,
            totalPages: response.data.metadata?.totalPages ?? 1,
            limit: response.data.metadata?.limit ?? 10,
            totalItems: response.data.metadata?.totalItems ?? 0,
          );
          return Success<OrdersResponseEntity>(
            data: OrdersResponseEntity(orders: orders, metadata: metadata),
          );
        }
      case Failure<OrdersDto>():
        {
          return Failure<OrdersResponseEntity>(
            errorMessage: response.errorMessage,
          );
        }
    }
  }
}
