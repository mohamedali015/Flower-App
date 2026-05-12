import '../../../error_handling/result.dart';
import '../../data/params/product_query_params.dart';
import '../entities/products_response_entity.dart';

abstract interface class ProductsRepo {
  Future<Result<ProductsResponseEntity>> getProducts({
    required ProductQueryParams params,
  });
}
