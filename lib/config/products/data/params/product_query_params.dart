class ProductQueryParams {
  final String? categoryId;
  final String? occasionId;
  final String? search;
  final String? sort;
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
      if (categoryId != null) 'category': categoryId,
      if (occasionId != null) 'occasion': occasionId,
      if (search != null) 'search': search,
      if (sort != null) 'sort': sort,
      if (page != null) 'page': page,
      if (limit != null) 'limit': limit,
    };
  }
}
