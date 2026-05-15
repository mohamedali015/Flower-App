import 'package:flower_app/config/products/data/mapper/product_mapper.dart';
import 'package:flower_app/features/home/data/model/home_response.dart';
import 'package:flower_app/features/home/domain/entities/home_response_entity.dart';

import 'best_seller_mapper.dart';
import 'categories_mapper.dart';
import 'occasions_mapper.dart';

extension HomeResponseMapper on HomeResponse {
  HomeResponseEntity toEntity() {
    return HomeResponseEntity(
      message: message ?? '',
      products: products?.map((e) => e.toEntity()).toList() ?? [],
      categories: categories?.map((e) => e.toEntity()).toList() ?? [],
      bestSeller: bestSeller?.map((e) => e.toEntity()).toList() ?? [],
      occasions: occasions?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}
