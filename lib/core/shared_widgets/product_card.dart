import 'package:flower_app/config/products/domain/entities/product_entity.dart';
import 'package:flower_app/core/helpers/my_responsive.dart';
import 'package:flower_app/core/localization/l10n/app_localizations.dart';
import 'package:flower_app/core/utils/app_colors.dart';
import 'package:flower_app/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

import 'cached_network_image_wrapper.dart';
import 'custom_add_to_cart.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;

  final VoidCallback? onAddToCart;

  const ProductCard({super.key, required this.product, this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    final hasDiscount = product.discount > 0;

    return Container(
      padding: MyResponsive.paddingAll(context, value: 8),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          MyResponsive.radius(context, value: 8),
        ),

        border: Border.all(color: AppColors.hintTextGray, width: 1.2),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          CachedNetworkImageWrapper(
            imagePath: product.imgCover,

            height: MyResponsive.height(context, value: 130),

            width: double.infinity,

            fit: BoxFit.cover,
          ),

          SizedBox(height: MyResponsive.height(context, value: 8)),

          Text(
            product.title,

            maxLines: 1,

            overflow: TextOverflow.ellipsis,

            style: AppTextStyles.regular12(
              context,
            ).copyWith(color: AppColors.darkBase),
          ),

          SizedBox(height: MyResponsive.height(context, value: 4)),

          Row(
            mainAxisSize: MainAxisSize.min,

            children: [
              Flexible(
                child: Text(
                  "${local.egp} ${product.priceAfterDiscount}",

                  maxLines: 1,

                  overflow: TextOverflow.ellipsis,

                  style: AppTextStyles.medium14(context),
                ),
              ),

              if (hasDiscount) ...[
                SizedBox(width: MyResponsive.width(context, value: 8)),

                Text(
                  "${product.price}",

                  style: AppTextStyles.regular12(context).copyWith(
                    color: AppColors.grayDark,

                    decoration: TextDecoration.lineThrough,
                  ),
                ),

                SizedBox(width: MyResponsive.width(context, value: 8)),

                Text(
                  "${product.discount}%",

                  style: AppTextStyles.regular12(
                    context,
                  ).copyWith(color: AppColors.success),
                ),
              ],
            ],
          ),
          SizedBox(height: MyResponsive.height(context, value: 8)),

          CustomAddToCart(onTap: onAddToCart),
        ],
      ),
    );
  }
}
