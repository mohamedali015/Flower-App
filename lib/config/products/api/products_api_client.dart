import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../../../core/values/api_end_points.dart';
import '../data/model/response/products_response.dart';

part 'products_api_client.g.dart';

@injectable
@RestApi()
abstract class ProductsApiClient {
  @factoryMethod
  factory ProductsApiClient(Dio dio) = _ProductsApiClient;

  @GET(ApiEndPoints.products)
  Future<ProductsResponse> getProducts(@Queries() Map<String, dynamic> queries);
}
