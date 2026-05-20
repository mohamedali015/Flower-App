import 'package:equatable/equatable.dart';

class ProductCartEntity extends Equatable {
  final String id;
  final String title;
  final String slug;
  final String description;
  final String imgCover;
  final List<String> images;
  final num price;
  final num priceAfterDiscount;
  final num discount;
  final num rateAvg;
  final num rateCount;
  final num sold;
  final num quantity;
  final String category;
  final String occasion;
  final bool isSuperAdmin;

  const ProductCartEntity({
    required this.id,
    required this.title,
    required this.slug,
    required this.description,
    required this.imgCover,
    required this.images,
    required this.price,
    required this.priceAfterDiscount,
    required this.discount,
    required this.rateAvg,
    required this.rateCount,
    required this.sold,
    required this.quantity,
    required this.category,
    required this.occasion,
    required this.isSuperAdmin,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    slug,
    description,
    imgCover,
    images,
    price,
    priceAfterDiscount,
    discount,
    rateAvg,
    rateCount,
    sold,
    quantity,
    category,
    occasion,
    isSuperAdmin,
  ];
}
