import '../../domain/entities/metadata_entity.dart';
import '../../domain/entities/products_response_entity.dart';
import '../model/response/products_response.dart';
import 'product_mapper.dart';

extension ProductsResponseMapper on ProductsResponse {
  ProductsResponseEntity toEntity() {
    return ProductsResponseEntity(
      products: products?.map((e) => e.toEntity()).toList() ?? [],
      metadata: MetadataEntity(
        currentPage: metadata?.currentPage ?? 1,
        totalPages: metadata?.totalPages ?? 1,
        limit: metadata?.limit ?? 10,
        totalItems: metadata?.totalItems ?? 0,
      ),
    );
  }
}
