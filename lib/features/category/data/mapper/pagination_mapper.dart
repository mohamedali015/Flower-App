import 'package:flower_app/features/category/data/model/response/pagination.dart';
import 'package:flower_app/features/category/domain/entities/pagination_entity.dart';

extension PaginationMapper on Pagination {
  PaginationEntity toEntity() {
    return PaginationEntity(
      currentPage: currentPage,
      limit: limit,
      totalPages: totalPages,
      totalItems: totalItems,
    );
  }
}
