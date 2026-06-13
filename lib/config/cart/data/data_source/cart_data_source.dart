import 'package:flower_app/config/error_handling/result.dart';
import '../model/request/add_to_cart_request.dart';
import '../model/request/update_cart_request.dart';
import '../model/response/cart_response.dart';

abstract class GetCartDataSource {
  Future<Result<CartResponse>> getCart();
  Future<Result<CartResponse>> addToCart(AddToCartRequest request);
  Future<Result<CartResponse>> removeFromCart(String id);
  Future<Result<CartResponse>> updateCart(UpdateCartRequest quantity,String id);
  Future<Result<CartResponse>> deleteAllCart();
}