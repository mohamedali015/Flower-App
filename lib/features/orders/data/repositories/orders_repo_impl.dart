import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/orders/data/data_source/orders_remote_data_source.dart';
import 'package:flower_app/features/orders/data/mapper/orders_mapper.dart';
import 'package:flower_app/features/orders/data/models/orders_dto.dart';
import 'package:flower_app/features/orders/domain/entities/orders_entity.dart';
import 'package:flower_app/features/orders/domain/repositories/orders_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OrdersRepo)
class OrdersRepoImpl implements OrdersRepo {
  final OrdersRemoteDataSource remoteDataSource;

  OrdersRepoImpl(this.remoteDataSource);
  @override
  Future<Result<List<OrdersEntity>>> getOrders() async {
    final response = await remoteDataSource.getOrders();

    switch (response) {
      case Success<OrdersDto>():
        {
          return Success<List<OrdersEntity>>(
            data:
                response.data.orders
                    ?.map((orderDto) => orderDto.toEntity())
                    .toList() ??
                [],
          );
        }
      case Failure<OrdersDto>():
        {
          return Failure<List<OrdersEntity>>(
            errorMessage: response.errorMessage,
          );
        }
    }
  }
}
