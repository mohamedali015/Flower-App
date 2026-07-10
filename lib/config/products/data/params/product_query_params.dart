import 'package:flower_app/features/filter/domain/enums/sort_options.dart';
import 'package:flower_app/features/filter/domain/sort_option_factory.dart';

class ProductQueryParams {
  final String? categoryId;
  final String? occasionId;
  final String? search;
  final SortOption? sort;
  final int? page;
  final int? limit;

  const ProductQueryParams({
    this.categoryId,
    this.occasionId,
    this.search,
    this.sort,
    this.page,
    this.limit,
  });

  Map<String, dynamic> toJson() {
    return {
      if (categoryId != null && categoryId!.isNotEmpty) 'category': categoryId,
      if (occasionId != null) 'occasion': occasionId,
      if (search != null) 'search': search,
      if (sort != null) 'sort': SortOptionFactory.toApiKey(sort!),
      if (page != null) 'page': page,
      if (limit != null) 'limit': limit,
    };
  }
}
