import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/helpers/my_responsive.dart';
import '../../../../core/localization/l10n/app_localizations.dart';
import '../../../../core/shared_widgets/custom_search_bar.dart';
import '../../../../core/shared_widgets/svg_wrapper.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';

class CustomHeaderCategory extends StatelessWidget {
  const CustomHeaderCategory({super.key});

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    return Row(
      children: [
        CustomSearchBar(
          horizontal: 20,
          vertical: 15,
        ),
        SizedBox(width: MyResponsive.width(context, value: 8)),
        GestureDetector(
          onTap: () {},
          child: Container(
            padding: MyResponsive.paddingSymmetric(
              context,
              horizontal: 20,
              vertical: 15,
            ),
            alignment: Alignment.center,

            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(
                MyResponsive.radius(context, value: 8),
              ),

              border: Border.all(
                color: AppColors.textHint,
                width: MyResponsive.width(context, value: 1.5),
              ),
            ),

            child: SvgWrapper(
              path: AppAssets.sortIcons,
              width: MyResponsive.width(value: 18, context),
              height: MyResponsive.height(value: 12, context),
              fit: BoxFit.contain,
              color: AppColors.textHint,
            ),
          ),
        ),
      ],
    );
  }
}
