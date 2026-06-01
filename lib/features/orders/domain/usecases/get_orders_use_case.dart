import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/orders/domain/entities/orders_entity.dart';
import 'package:flower_app/features/orders/domain/entities/orders_grouped_entity.dart';
import 'package:flower_app/features/orders/domain/repositories/orders_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetOrdersUseCase {
  final OrdersRepo _repo;
  GetOrdersUseCase(this._repo);

  Future<Result<OrdersGroupedEntity>> call() async {
    final result = await _repo.getOrders();

    if (result is Success<List<OrdersEntity>>) {
      final orders = result.data;

      final pending = orders.where((e) => e.isDelivered != true).toList();

      final delivered = orders.where((e) => e.isDelivered == true).toList();

      return Success(
        data: OrdersGroupedEntity(pending: pending, delivered: delivered),
      );
    } else if (result is Failure<List<OrdersEntity>>) {
      return Failure(errorMessage: result.errorMessage);
    }

    throw Exception("Unhandled result type");
  }
}
