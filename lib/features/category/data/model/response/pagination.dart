import 'package:json_annotation/json_annotation.dart';

part 'pagination.g.dart';
@JsonSerializable()
class Pagination {
  @JsonKey(name: "currentPage")
  final int? currentPage;
  @JsonKey(name: "limit")
  final int? limit;
  @JsonKey(name: "totalPages")
  final int? totalPages;
  @JsonKey(name: "totalItems")
  final int? totalItems;

  Pagination ({
    this.currentPage,
    this.limit,
    this.totalPages,
    this.totalItems,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return _$PaginationFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PaginationToJson(this);
  }
}