import 'package:flutter/material.dart';
import '../helpers/my_responsive.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import 'cached_network_image_wrapper.dart';
import 'custom_add_to_cart.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final String image;
  final num price;
  final num priceAfterDiscount;
  final num discount;
  final VoidCallback? onAddToCart;

  const ProductCard({
    super.key,
    required this.name,
    required this.image,
    required this.price,
    required this.priceAfterDiscount,
    required this.discount,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: MyResponsive.paddingAll(context, value: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          MyResponsive.radius(context, value: 8),
        ),
        border: Border.all(color: AppColors.hintTextGray, width: 1.2),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImageWrapper(
            imagePath: image,
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
          ),

          SizedBox(height: MyResponsive.height(context, value: 6)),

          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.regular14(
              context,
            ).copyWith(fontWeight: FontWeight.bold, color: AppColors.darkBase),
          ),

          SizedBox(height: MyResponsive.height(context, value: 6)),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "EGP  $priceAfterDiscount",
                style: AppTextStyles.regular14(
                  context,
                ).copyWith(fontWeight: FontWeight.bold),
              ),

              Text(
                "$price",
                style: AppTextStyles.regular14(context).copyWith(
                  color: AppColors.grayDark,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              Text(
                "$discount%",
                style: AppTextStyles.regular14(context).copyWith(
                  color: AppColors.success,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          SizedBox(height: MyResponsive.height(context, value: 6)),

          CustomAddToCart(onTap: onAddToCart),
        ],
      ),
    );
  }
}
