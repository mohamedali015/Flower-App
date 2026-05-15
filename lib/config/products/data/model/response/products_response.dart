import 'package:flower_app/config/products/data/model/response/product_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'metadata_model.dart';

part 'products_response.g.dart';

@JsonSerializable()
class ProductsResponse {
  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'metadata')
  final MetadataModel? metadata;

  @JsonKey(name: 'products')
  final List<ProductModel>? products;

  ProductsResponse({this.message, this.metadata, this.products});

  factory ProductsResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductsResponseFromJson(json);
}
