import 'package:flower_app/core/helpers/date_time_extension.dart';
import 'package:flower_app/core/localization/l10n/app_localizations.dart';
import 'package:flower_app/core/utils/app_colors.dart';
import 'package:flower_app/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class EstimatedArrivedWidget extends StatelessWidget {
  const EstimatedArrivedWidget({super.key, required this.estimatedTime});

  final DateTime estimatedTime;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localizations.estimatedArrived,
            style: AppTextStyles.medium14(
              context,
            ).copyWith(color: AppColors.grayDark),
          ),
          const SizedBox(height: 8),
          Text(
            estimatedTime.toDayMonthYearTime(),
            style: AppTextStyles.medium16(context),
          ),
        ],
      ),
    );
  }
}
