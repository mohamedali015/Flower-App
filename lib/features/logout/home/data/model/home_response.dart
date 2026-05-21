import 'package:flower_app/config/products/data/model/response/product_model.dart';
import 'package:flower_app/features/logout/home/data/model/best_seller.dart';
import 'package:flower_app/features/logout/home/data/model/categories.dart';
import 'package:flower_app/features/logout/home/data/model/occasions.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_response.g.dart';

@JsonSerializable()
class HomeResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "products")
  final List<ProductModel>? products;
  @JsonKey(name: "categories")
  final List<Categories>? categories;
  @JsonKey(name: "bestSeller")
  final List<BestSeller>? bestSeller;
  @JsonKey(name: "occasions")
  final List<Occasions>? occasions;

  HomeResponse({
    this.message,
    this.products,
    this.categories,
    this.bestSeller,
    this.occasions,
  });

  factory HomeResponse.fromJson(Map<String, dynamic> json) {
    return _$HomeResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$HomeResponseToJson(this);
  }
}
