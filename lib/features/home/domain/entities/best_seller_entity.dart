import 'package:equatable/equatable.dart';

class BestSellerEntity extends Equatable {
  final String? title;

  final String? imgCover;

  final int? price;
  final int? priceAfterDiscount;
  final int? discount;

  const BestSellerEntity({
    required this.title,
    required this.imgCover,
    required this.price,
    required this.priceAfterDiscount,
    required this.discount,
  });

  @override
  List<Object?> get props => [
    title,
    imgCover,
    price,
    priceAfterDiscount,
    discount,
  ];
}
