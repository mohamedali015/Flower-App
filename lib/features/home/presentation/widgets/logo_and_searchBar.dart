import 'package:flower_app/core/helpers/my_responsive.dart';
import 'package:flower_app/core/localization/l10n/app_localizations.dart';
import 'package:flower_app/core/utils/app_assets.dart';
import 'package:flower_app/core/utils/app_colors.dart';
import 'package:flower_app/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class LogoAndSearchBar extends StatelessWidget {
  const LogoAndSearchBar({super.key, required this.local});

  final AppLocalizations local;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          AppAssets.logo,
          height: MyResponsive.height(context, value: 25),
          width: MyResponsive.width(context, value: 90),
        ),
        SizedBox(width: MyResponsive.width(context, value: 17)),
        Expanded(
          child: Container(
            padding: MyResponsive.paddingSymmetric(
              context,
              vertical: 9.5,
              horizontal: 11,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(
                MyResponsive.radius(context, value: 8),
              ),
              border: Border.all(color: AppColors.grayMedium),
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: AppColors.grayMedium, size: 20),
                SizedBox(width: MyResponsive.width(context, value: 6)),
                Text(
                  local.search,
                  style: AppTextStyles.medium14(
                    context,
                  ).copyWith(color: AppColors.grayMedium),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
