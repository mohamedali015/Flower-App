import 'package:flutter/material.dart';
import '../localization/l10n/app_localizations.dart';
import '../utils/app_assets.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import 'svg_wrapper.dart';

class CustomAddToCart extends StatelessWidget {
  final VoidCallback? onTap;

  const CustomAddToCart({super.key, this.onTap});

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
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),

            decoration: BoxDecoration(
              color: AppColors.primaryColor,

              borderRadius: BorderRadius.circular(100),
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                const SvgWrapper(
                  path: AppAssets.addCartIcon,
                  fit: BoxFit.cover,
                  width: 15,
                  height: 15,
                ),

                const SizedBox(width: 8),

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
