import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/orders/domain/entities/orders_entity.dart';

abstract class OrdersRepo {
  Future<Result<List<OrdersEntity>>> getOrders();
}
