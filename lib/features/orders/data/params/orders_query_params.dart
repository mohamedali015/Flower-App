class OrdersQueryParams {
  final int? page;
  final int? limit;

  const OrdersQueryParams({this.page, this.limit});

  Map<String, dynamic> toJson() {
    return {if (page != null) 'page': page, if (limit != null) 'limit': limit};
  }
}
