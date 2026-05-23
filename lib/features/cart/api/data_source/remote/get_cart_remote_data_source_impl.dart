import 'package:flower_app/config/error_handling/execute_api.dart';
import 'package:flower_app/features/cart/data/model/request/update_cart_request.dart';
import 'package:flower_app/features/cart/data/model/response/cart_response.dart';
import 'package:injectable/injectable.dart';
import '../../../../../config/error_handling/result.dart';
import '../../../data/data_source/cart_data_source.dart';
import '../../cart_api_client.dart';

@Injectable(as: GetCartDataSource)
class GetCartRemoteDataSourceImpl implements GetCartDataSource {
  final CartApiClient _apiClient;

  GetCartRemoteDataSourceImpl(this._apiClient);

  ///////////// Get Cart //////////////////
  @override
  Future<Result<CartResponse>> getCart() {
    return executeApi(() async {
      return _apiClient.getCart();
    });
  }

  ///////////// Remove From Cart //////////////////
  @override
  Future<Result<CartResponse>> removeFromCart(String id) {
    return executeApi(() async {
      return _apiClient.removeFromCart(id);
    });
  }

  ////////////// Update Cart //////////////////
  @override
  Future<Result<CartResponse>> updateCart(UpdateCartRequest quantity,String id) {
    return executeApi(() async {
      return _apiClient.updateCart(quantity,id);
    });
  }
}
