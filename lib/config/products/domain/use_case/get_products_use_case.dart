import 'package:injectable/injectable.dart';
import '../../../error_handling/result.dart';
import '../../data/params/product_query_params.dart';
import '../entities/products_response_entity.dart';
import '../repositories/products_repo.dart';

@injectable
class GetProductsUseCase {
  final ProductsRepo _repo;

  GetProductsUseCase(this._repo);

  Future<Result<ProductsResponseEntity>> call({
    required ProductQueryParams params,
  }) {
    return _repo.getProducts(params: params);
  }
}
