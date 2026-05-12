import 'package:injectable/injectable.dart';
import '../../../error_handling/result.dart';
import '../../domain/entities/products_response_entity.dart';
import '../../domain/repositories/products_repo.dart';
import '../data_source/remote/products_remote_data_source.dart';
import '../mapper/products_response_mapper.dart';
import '../model/response/products_response.dart';
import '../params/product_query_params.dart';

@Injectable(as: ProductsRepo)
class ProductsRepoImpl implements ProductsRepo {
  final ProductsRemoteDataSource _remote;

  ProductsRepoImpl(this._remote);

  @override
  Future<Result<ProductsResponseEntity>> getProducts({
    required ProductQueryParams params,
  }) async {
    final response = await _remote.getProducts(params: params);

    switch (response) {
      case Success<ProductsResponse>():
        return Success(data: response.data.toEntity());

      case Failure<ProductsResponse>():
        return Failure(errorMessage: response.errorMessage);
    }
  }
}
