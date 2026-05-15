import 'package:json_annotation/json_annotation.dart';

part 'all_categories_response.g.dart';
@JsonSerializable()
class AllCategoriesResponse {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "slug")
  final String? slug;
  @JsonKey(name: "image")
  final String? image;
  @JsonKey(name: "isSuperAdmin")
  final bool? isSuperAdmin;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;
  @JsonKey(name: "productsCount")
  final int? productsCount;

  AllCategoriesResponse ({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.isSuperAdmin,
    this.createdAt,
    this.updatedAt,
    this.productsCount,
  });

  factory AllCategoriesResponse.fromJson(Map<String, dynamic> json) {
    return _$AllCategoriesResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AllCategoriesResponseToJson(this);
  }
}