import '../../../../error_handling/result.dart';
import '../../model/response/products_response.dart';
import '../../params/product_query_params.dart';

abstract interface class ProductsRemoteDataSource {
  Future<Result<ProductsResponse>> getProducts({
    required ProductQueryParams params,
  });
}
