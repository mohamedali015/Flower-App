import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/orders/data/params/orders_query_params.dart';
import 'package:flower_app/features/orders/domain/entities/orders_response_entity.dart';

abstract class OrdersRepo {
  Future<Result<OrdersResponseEntity>> getOrders({OrdersQueryParams? params});
}
