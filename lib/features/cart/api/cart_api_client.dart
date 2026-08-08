import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../../../core/values/api_end_points.dart';
import '../data/model/request/update_cart_request.dart';
import '../data/model/response/cart_response.dart';
part 'cart_api_client.g.dart';

@injectable
@RestApi()
abstract class CartApiClient {
  @factoryMethod
  factory CartApiClient(Dio dio) = _CartApiClient;

  ////////////////// Get Cart //////////////////
  @GET(ApiEndPoints.cart)
  Future<CartResponse> getCart();


  ////////////////// Remove From Cart //////////////////
  @DELETE("${ApiEndPoints.cart}/{id}")
  Future<CartResponse> removeFromCart(@Path("id") String id);

  ///////////////// Update Cart //////////////////////////
  @PUT("${ApiEndPoints.cart}/{productId}")
  Future<CartResponse> updateCart(
      @Body() UpdateCartRequest body,
      @Path("productId") String id
      );

}
