import 'package:injectable/injectable.dart';
import 'package:flower_app/features/filter/domain/enums/sort_options.dart';

import '../../../error_handling/result.dart';
import '../../data/params/product_query_params.dart';
import '../entities/product_entity.dart';
import '../entities/products_response_entity.dart';
import '../repositories/products_repo.dart';

@injectable
class GetProductsUseCase {
  final ProductsRepo _repo;

  GetProductsUseCase(this._repo);

  Future<Result<ProductsResponseEntity>> call({
    required ProductQueryParams params,
  }) async {
    final result = await _repo.getProducts(params: params);

    switch (result) {
      case Success<ProductsResponseEntity>():
        final sorted = _applySorting(result.data.products, params.sort);
        return Success(
          data: ProductsResponseEntity(
            products: sorted,
            metadata: result.data.metadata,
          ),
        );

      case Failure<ProductsResponseEntity>():
        return Failure(errorMessage: result.errorMessage);
    }
  }

  List<ProductEntity> _applySorting(
    List<ProductEntity> products,
    SortOption? sort,
  ) {
    final list = List<ProductEntity>.from(products);

    switch (sort) {
      case SortOption.lowestPrice:
        list.sort(
          (a, b) => a.priceAfterDiscount.compareTo(b.priceAfterDiscount),
        );
      case SortOption.highestPrice:
        list.sort(
          (a, b) => b.priceAfterDiscount.compareTo(a.priceAfterDiscount),
        );
      case SortOption.discount:
        list.sort((a, b) => b.discount.compareTo(a.discount));
      default:
        break;
    }

    return list;
  }
}
