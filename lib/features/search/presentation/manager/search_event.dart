import 'package:equatable/equatable.dart';
import '../../../../config/products/data/params/product_query_params.dart';

sealed class SearchEvent extends Equatable {}

class SearchProductEvent extends SearchEvent {
  final ProductQueryParams search;
  SearchProductEvent({required this.search});
  @override
  List<Object?> get props => [search];
}
