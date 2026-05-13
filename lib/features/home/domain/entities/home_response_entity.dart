import 'package:equatable/equatable.dart';
import 'package:flower_app/config/products/domain/entities/product_entity.dart';
import 'categories_entity.dart';
import 'best_seller_entity.dart';
import 'occasions_entity.dart';

class HomeResponseEntity extends Equatable {
  final String message;
  final List<ProductEntity> products;
  final List<CategoriesEntity> categories;
  final List<BestSellerEntity> bestSeller;
  final List<OccasionsEntity> occasions;

  const HomeResponseEntity({
    required this.message,
    required this.products,
    required this.categories,
    required this.bestSeller,
    required this.occasions,
  });

  @override
  List<Object?> get props => [
    message,
    products,
    categories,
    bestSeller,
    occasions,
  ];
}
