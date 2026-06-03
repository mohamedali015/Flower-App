import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/orders/data/params/orders_query_params.dart';
import 'package:flower_app/features/orders/domain/entities/orders_grouped_entity.dart';
import 'package:flower_app/features/orders/domain/entities/orders_response_entity.dart';
import 'package:flower_app/features/orders/domain/repositories/orders_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetOrdersUseCase {
  final OrdersRepo _repo;
  GetOrdersUseCase(this._repo);

  Future<Result<OrdersGroupedEntity>> call({OrdersQueryParams? params}) async {
    final result = await _repo.getOrders(params: params);

    if (result is Success<OrdersResponseEntity>) {
      final orders = result.data.orders;
      final metadata = result.data.metadata;

      final active = orders.where((e) => e.isDelivered != true).toList();

      final delivered = orders.where((e) => e.isDelivered == true).toList();

      return Success(
        data: OrdersGroupedEntity(
          active: active,
          delivered: delivered,
          metadata: metadata,
        ),
      );
    } else if (result is Failure<OrdersResponseEntity>) {
      return Failure(errorMessage: result.errorMessage);
    }

    throw Exception("Unhandled result type");
  }
}
