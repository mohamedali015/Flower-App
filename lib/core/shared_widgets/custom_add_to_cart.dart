import 'package:flutter/material.dart';
import '../localization/l10n/app_localizations.dart';
import '../utils/app_assets.dart';
import '../utils/app_colors.dart';
import 'svg_wrapper.dart';

class CustomAddToCart extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomAddToCart({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return ElevatedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SvgWrapper(
            path: AppAssets.cartIcon,
            color: AppColors.white,
            width: 15,
            height: 15,
          ),
          const SizedBox(width: 8),
          Text(local.addToCart),
        ],
      ),
    );
  }
}
