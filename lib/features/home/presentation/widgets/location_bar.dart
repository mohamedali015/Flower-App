import 'package:flower_app/core/helpers/my_responsive.dart';
import 'package:flower_app/core/localization/l10n/app_localizations.dart';
import 'package:flower_app/core/shared_widgets/svg_wrapper.dart';
import 'package:flower_app/core/utils/app_assets.dart';
import 'package:flower_app/core/utils/app_colors.dart';
import 'package:flower_app/core/utils/app_text_styles.dart';
import 'package:flower_app/core/values/app_strings.dart';
import 'package:flutter/material.dart';

class LocationBar extends StatelessWidget {
  const LocationBar({super.key, required this.local});

  final AppLocalizations local;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MyResponsive.paddingSymmetric(context, vertical: 17),
      child: Row(
        children: [
          SvgWrapper(
            path: AppAssets.location,
            width: MyResponsive.width(context, value: 16),
            height: MyResponsive.height(context, value: 16),
          ),
          SizedBox(width: MyResponsive.width(context, value: 5)),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: local.deliverTo,
                  style: AppTextStyles.medium14(
                    context,
                  ).copyWith(color: AppColors.darkShade6),
                ),
                TextSpan(
                  text: AppStrings.address,
                  style: AppTextStyles.medium14(
                    context,
                  ).copyWith(color: AppColors.black100),
                ),
              ],
            ),
          ),
          SvgWrapper(
            path: AppAssets.pinkArrow,
            width: MyResponsive.width(context, value: 16),
            height: MyResponsive.height(context, value: 16),
          ),
        ],
      ),
    );
  }
}
