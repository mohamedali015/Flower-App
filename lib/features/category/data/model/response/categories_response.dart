import 'package:flower_app/features/category/data/model/response/pagination.dart';
import 'package:json_annotation/json_annotation.dart';

import 'all_categories_response.dart';

part 'categories_response.g.dart';

@JsonSerializable()
class CategoriesResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "metadata")
  final Pagination? pagination;
  @JsonKey(name: "categories")
  final List<AllCategoriesResponse>? categories;

  CategoriesResponse ({
    this.message,
    this.pagination,
    this.categories,
  });

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) {
    return _$CategoriesResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CategoriesResponseToJson(this);
  }
}






