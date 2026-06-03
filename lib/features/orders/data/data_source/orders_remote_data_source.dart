import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/orders/data/models/orders_dto.dart';
import 'package:flower_app/features/orders/data/params/orders_query_params.dart';

abstract class OrdersRemoteDataSource {
  Future<Result<OrdersDto>> getOrders({OrdersQueryParams? params});
}
