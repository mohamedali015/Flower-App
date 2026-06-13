import 'package:dio/dio.dart';
import 'package:flower_app/core/values/api_end_points.dart';
import 'package:flower_app/features/orders/data/models/orders_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'orders_api_client.g.dart';

@injectable
@RestApi()
abstract class OrdersApiClient {
  @factoryMethod
  factory OrdersApiClient(Dio dio) = _OrdersApiClient;

  @GET(ApiEndPoints.getOrders)
  Future<OrdersDto> getOrders({@Queries() Map<String, dynamic>? queryParams});
}
