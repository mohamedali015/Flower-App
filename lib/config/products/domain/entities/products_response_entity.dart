import 'package:equatable/equatable.dart';

import 'metadata_entity.dart';
import 'product_entity.dart';

class ProductsResponseEntity extends Equatable {
  final List<ProductEntity> products;
  final MetadataEntity metadata;

  const ProductsResponseEntity({
    required this.products,
    required this.metadata,
  });

  @override
  List<Object?> get props => [products, metadata];
}
