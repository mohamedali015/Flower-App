import 'package:flower_app/features/home/data/model/best_seller.dart';
import 'package:flower_app/features/home/domain/entities/best_seller_entity.dart';

extension BestSellerMapper on BestSeller {
  BestSellerEntity toEntity() {
    return BestSellerEntity(
      title: title ?? '',
      imgCover: imgCover ?? '',
      price: price ?? 0,
      priceAfterDiscount: priceAfterDiscount ?? 0,
      discount: discount ?? 0,
    );
  }
}
