import 'package:injectable/injectable.dart';

import '../../../../error_handling/execute_api.dart';
import '../../../../error_handling/result.dart';
import '../../../data/data_source/remote/products_remote_data_source.dart';
import '../../../data/model/response/products_response.dart';
import '../../../data/params/product_query_params.dart';
import '../../products_api_client.dart';

@Injectable(as: ProductsRemoteDataSource)
class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSource {
  final ProductsApiClient _apiClient;

  ProductsRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Result<ProductsResponse>> getProducts({
    required ProductQueryParams params,
  }) {
    return executeApi(() {
      return _apiClient.getProducts(params.toJson());
    });
  }
}
