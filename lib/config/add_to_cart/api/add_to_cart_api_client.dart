import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../../../core/values/api_end_points.dart';
import '../../../features/cart/data/model/request/add_to_cart_request.dart';
import '../../../features/cart/data/model/response/cart_response.dart';
part 'add_to_cart_api_client.g.dart';

@injectable
@RestApi()
abstract class AddToCartApiClient {
  @factoryMethod
  factory AddToCartApiClient(Dio dio) = _AddToCartApiClient;

  ////////////////// Add To Cart //////////////////
  @POST(ApiEndPoints.cart)
  Future<CartResponse> addToCart(@Body() AddToCartRequest request);
}
