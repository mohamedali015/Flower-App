import 'package:equatable/equatable.dart';

import '../../../../config/products/data/params/product_query_params.dart';

sealed class CategoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetAllCategoryEvent extends CategoryEvent{

}

class ProductEvent extends CategoryEvent{
  final ProductQueryParams categoryId;
  ProductEvent({required this.categoryId});
  @override
  List<Object?> get props => [];
}