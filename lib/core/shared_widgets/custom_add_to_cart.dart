import 'package:flutter/material.dart';

import '../helpers/my_responsive.dart';
import '../localization/l10n/app_localizations.dart';
import '../utils/app_assets.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import 'svg_wrapper.dart';

class CustomAddToCart extends StatelessWidget {
  final VoidCallback? onTap;
  final double widthContainer;
  const CustomAddToCart({
    super.key,
    this.onTap,
    this.widthContainer = 35,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return SizedBox(
      width: double.infinity,
      child: Material(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: onTap,

          child: Container(
            height: MyResponsive.height(context, value: widthContainer),

            padding: MyResponsive.paddingSymmetric(
              context,
              vertical: 6,
              horizontal: 20,
            ),

            decoration: BoxDecoration(
              color: AppColors.primaryColor,

              borderRadius: BorderRadius.circular(
                MyResponsive.radius(context, value: 25),
              ),
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                SvgWrapper(
                  path: AppAssets.addCartIcon,
                  fit: BoxFit.cover,
                  width: MyResponsive.width(context, value: 24),
                  height: MyResponsive.height(context, value: 24),
                ),

                SizedBox(
                  width: MyResponsive.width(context, value: 8),
                ),

                Text(
                  local.add_to_cart,
                  style: AppTextStyles.medium14(context).copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}