import 'package:flutter/material.dart';

import '../../../../core/localization/l10n/app_localizations.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../domain/entities/get_cart_entity.dart';

class CustomTotalPrice extends StatelessWidget {
  const CustomTotalPrice({
    super.key,
    this.product,
    required this.subTotal,
    required this.deliveryFee,
  });

  final GetCartEntity? product;
  final num subTotal;
  final num deliveryFee;

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;

    final total = subTotal + deliveryFee;

    return Column(
      children: [
        Row(
          children: [
            Text(
              local.sub_total,
              style: AppTextStyles.regular16(
                context,
              ).copyWith(color: AppColors.grayDark),
            ),
            const Spacer(),
            Text(
              '\$$subTotal',
              style: AppTextStyles.regular16(
                context,
              ).copyWith(color: AppColors.grayDark),
            ),
          ],
        ),

        const SizedBox(height: 8),

        Row(
          children: [
            Text(
              local.deliveryFee,
              style: AppTextStyles.regular16(
                context,
              ).copyWith(color: AppColors.grayDark),
            ),
            const Spacer(),
            Text(
              '\$$deliveryFee',
              style: AppTextStyles.regular16(
                context,
              ).copyWith(color: AppColors.grayDark),
            ),
          ],
        ),

        const SizedBox(height: 16),

        const Divider(thickness: 2, color: AppColors.grayMedium),

        Row(
          children: [
            Text(local.total, style: AppTextStyles.medium18(context)),
            const Spacer(),
            Text('\$$total', style: AppTextStyles.medium18(context)),
          ],
        ),
      ],
    );
  }
}
