import 'package:flutter/cupertino.dart';
import '../../../../core/localization/l10n/app_localizations.dart';
import '../../../../core/shared_widgets/cached_network_image_wrapper.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../domain/entities/cart_item_entity.dart';

class CustomCartItem extends StatelessWidget {
  const CustomCartItem({
    super.key,
    required this.cartItem,
    this.onDelete,
    this.onIncrease,
    this.onDecrease,
  });

  final CartItemEntity cartItem;
  final VoidCallback? onDelete;
  final VoidCallback? onIncrease;
  final VoidCallback? onDecrease;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.grayDark),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImageWrapper(
              imagePath: cartItem.productEntity.imgCover,
              width: 95,
              height: 120,
            ),
          ),

          const SizedBox(width: 12),

          /// Details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    cartItem.productEntity.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.medium16(
                      context,
                    ).copyWith(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    cartItem.productEntity.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.medium14(
                      context,
                    ).copyWith(color: AppColors.darkBase.withOpacity(0.6)),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "${local.egp} ${cartItem.productEntity.priceAfterDiscount}",
                    style: AppTextStyles.semiBold14(context).copyWith(
                      color: AppColors.error,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 10),

          /// Action ( Add , Delete)
          SizedBox(
            height: 90,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: onDelete,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.error.withOpacity(0.1),
                    ),
                    child: const Icon(
                      CupertinoIcons.delete,
                      color: AppColors.error,
                      size: 25,
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.grayDark.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: onDecrease,
                        child: const Icon(CupertinoIcons.minus, size: 25),
                      ),

                      const SizedBox(width: 8),

                      Text(
                        cartItem.quantity.toString(),
                        style: AppTextStyles.medium14(
                          context,
                        ).copyWith(fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(width: 10),

                      GestureDetector(
                        onTap: onIncrease,
                        child: const Icon(CupertinoIcons.plus, size: 25),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
