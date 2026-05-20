import '../../../../features/cart/data/model/request/add_to_cart_request.dart';
import '../../../../features/cart/data/model/response/cart_response.dart';
import '../../../error_handling/result.dart';

abstract class AddToCartDataSource {
  Future<Result<CartResponse>> addToCart(AddToCartRequest request);
}
