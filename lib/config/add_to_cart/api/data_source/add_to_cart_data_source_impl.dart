import 'package:flower_app/config/add_to_cart/date/data_source/add_to_cart_data_source.dart';
import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/cart/data/model/request/add_to_cart_request.dart';
import 'package:flower_app/features/cart/data/model/response/cart_response.dart';
import 'package:injectable/injectable.dart';
import '../../../error_handling/execute_api.dart';
import '../add_to_cart_api_client.dart';

@Injectable(as: AddToCartDataSource)
class AddToCartDataSourceImpl implements AddToCartDataSource {
  final AddToCartApiClient _apiClient;
  AddToCartDataSourceImpl(this._apiClient);

  ///////////// Add To Cart //////////////////
  @override
  Future<Result<CartResponse>> addToCart(AddToCartRequest request) {
    return executeApi(() async {
      return _apiClient.addToCart(request);
    });
  }
}
