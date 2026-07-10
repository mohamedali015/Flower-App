import '../../domain/entities/product_cart_entity.dart';
import '../model/response/get_all_product_response.dart';

extension ProductMapper on Product {
  ProductCartEntity toEntity() {
    return ProductCartEntity(
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
    );
  }
}
