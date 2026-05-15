import 'package:flower_app/config/products/domain/entities/product_entity.dart';
import 'package:flower_app/features/home/data/model/best_seller.dart';

extension BestSellerMapper on BestSeller {
  ProductEntity toEntity() {
    return ProductEntity(
      id: id ?? '',
      title: title ?? '',
      slug: slug ?? '',
      description: description ?? '',
      imgCover: imgCover ?? '',
      images: images ?? [],
      price: price ?? 0,
      priceAfterDiscount: priceAfterDiscount ?? 0,
      discount: discount ?? 0,
      rateAvg: rateAvg ?? 0,
      rateCount: rateCount ?? 0,
      sold: sold ?? 0,
      quantity: quantity ?? 0,
      category: category ?? '',
      occasion: occasion ?? '',
      isSuperAdmin: isSuperAdmin ?? false,
      createdAt: createdAt ?? DateTime.fromMillisecondsSinceEpoch(0),
      updatedAt: updatedAt ?? DateTime.fromMillisecondsSinceEpoch(0),
      v: V ?? 0,
      favoriteId: '',
      isInWishlist: null,
    );
  }
}
