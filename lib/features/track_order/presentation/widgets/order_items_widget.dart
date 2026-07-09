import 'package:flower_app/core/localization/l10n/app_localizations.dart';
import 'package:flower_app/core/shared_widgets/svg_wrapper.dart';
import 'package:flower_app/core/utils/app_assets.dart';
import 'package:flower_app/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../../../core/shared_widgets/cached_network_image_wrapper.dart';
import '../../../../core/utils/app_colors.dart';

class OrderItemsWidget extends StatelessWidget {
  const OrderItemsWidget({super.key, required this.products});

  final List products;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.grayDark.withValues(alpha: 0.25),
            blurRadius: 4,
            offset: Offset.zero,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SvgWrapper(path: AppAssets.cartIcon, width: 24, height: 24),
              const SizedBox(width: 8),
              Text(
                "${products.length} ",
                style: AppTextStyles.medium16(context),
              ),
              Text(
                AppLocalizations.of(context)!.items,
                style: AppTextStyles.medium16(context),
              ),
            ],
          ),
          Column(
            children: List.generate(3, (index) {
              return Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: OrderProductItem(
                  imageUrl: "",
                  title: "product $index",
                  subTitle: "this is product $index",
                  price: index.toString(),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class OrderProductItem extends StatelessWidget {
  const OrderProductItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.subTitle,
  });

  final String imageUrl;
  final String title;
  final String subTitle;
  final String price;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            width: 58,
            height: 60,
            child: imageUrl.isNotEmpty
                ? CachedNetworkImageWrapper(
                    imagePath: imageUrl,
                    fit: BoxFit.cover,
                  )
                : Image.asset(AppAssets.testImage, fit: BoxFit.cover),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.medium16(context)),
              const SizedBox(height: 4),
              Text(
                subTitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.regular13(
                  context,
                ).copyWith(color: AppColors.grayDark),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localizations.egp,
              style: AppTextStyles.semiBold14(
                context,
              ).copyWith(color: AppColors.darkBase),
            ),
            const SizedBox(width: 4),
            Text(
              price,
              style: AppTextStyles.semiBold14(
                context,
              ).copyWith(color: AppColors.darkBase),
            ),
          ],
        ),
      ],
    );
  }
}
