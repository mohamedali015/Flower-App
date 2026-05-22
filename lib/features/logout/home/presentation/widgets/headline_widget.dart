import 'package:flower_app/core/localization/l10n/app_localizations.dart';
import 'package:flower_app/core/utils/app_colors.dart';
import 'package:flower_app/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class HeadlineWidget extends StatelessWidget {
  final String title;
  final bool isViewAll;
  final AppLocalizations local;
  final VoidCallback? onViewAllPressed;
  const HeadlineWidget({
    super.key,
    required this.title,
    this.isViewAll = true,
    this.onViewAllPressed,
    required this.local,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.medium18(
                  context,
                ).copyWith(color: AppColors.black100),
              ),
            ),

            isViewAll
                ? TextButton(
                    onPressed: onViewAllPressed,
                    child: Text(
                      local.viewAll,
                      style: AppTextStyles.medium12(context).copyWith(
                        color: AppColors.primaryColor,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primaryColor,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ],
    );
  }
}
