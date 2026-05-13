import 'package:flutter/material.dart';

import '../helpers/my_responsive.dart';
import '../localization/l10n/app_localizations.dart';
import '../utils/app_assets.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import 'svg_wrapper.dart';

class CustomAddToCart extends StatelessWidget {
  final VoidCallback? onTap;
  final double heightContainer;

  const CustomAddToCart({super.key, this.onTap, this.heightContainer = 30});

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
            height: MyResponsive.height(context, value: heightContainer),

            padding: MyResponsive.paddingSymmetric(
              context,
              vertical: 6,
              horizontal: 10,
            ),

            decoration: BoxDecoration(
              color: AppColors.primaryColor,

              borderRadius: BorderRadius.circular(
                MyResponsive.radius(context, value: 100),
              ),
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                SvgWrapper(
                  path: AppAssets.addCartIcon,
                  fit: BoxFit.cover,
                  width: MyResponsive.width(context, value: 15),
                  height: MyResponsive.height(context, value: 15),
                ),

                SizedBox(width: MyResponsive.width(context, value: 8)),

                Text(
                  local.addToCart,
                  style: AppTextStyles.medium13(
                    context,
                  ).copyWith(color: AppColors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
