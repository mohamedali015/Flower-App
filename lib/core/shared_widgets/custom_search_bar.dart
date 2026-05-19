import 'package:flutter/material.dart';

import '../../config/route_manager/routes.dart';
import '../helpers/my_responsive.dart';
import '../localization/l10n/app_localizations.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class CustomSearchBar extends StatelessWidget {
  final double? vertical;
  final double? horizontal;

  const CustomSearchBar({super.key, this.vertical = 9.5, this.horizontal = 11});

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    return Expanded(
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, Routes.searchScreenRoute),
        child: Container(
          padding: MyResponsive.paddingSymmetric(
            context,
            vertical: vertical,
            horizontal: horizontal,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              MyResponsive.radius(context, value: 8),
            ),
            border: Border.all(color: AppColors.grayMedium),
          ),
          child: Row(
            children: [
              const Icon(Icons.search, color: AppColors.grayMedium, size: 20),
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
    );
  }
}
