import 'package:flower_app/config/error_handling/execute_api.dart';
import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/orders/api/orders_api_client.dart';
import 'package:flower_app/features/orders/data/data_source/orders_remote_data_source.dart';
import 'package:flower_app/features/orders/data/models/orders_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OrdersRemoteDataSource)
class OrdersRemoteDataSourceImpl implements OrdersRemoteDataSource {
  final OrdersApiClient _apiClient;
  OrdersRemoteDataSourceImpl(this._apiClient);
  @override
  Future<Result<OrdersDto>> getOrders() {
    return executeApi<OrdersDto>(() {
      return _apiClient.getOrders();
    });
  }
}
