import 'package:flower_app/core/shared_widgets/svg_wrapper.dart';
import 'package:flower_app/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class TrackOrderInfoCard extends StatelessWidget {
  const TrackOrderInfoCard({
    super.key,
    required this.iconPath,
    required this.title,
    required this.subTitle,
  });

  final String iconPath;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.grayDark.withValues(alpha: 0.25),
            blurRadius: 4,
            offset: Offset.zero,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgWrapper(
                path: iconPath,
                width: 24,
                height: 24,
                color: AppColors.grayNeutral,
              ),
              const SizedBox(width: 8),
              Text(title, style: AppTextStyles.medium16(context)),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            subTitle,
            style: AppTextStyles.regular13(
              context,
            ).copyWith(color: AppColors.grayDark),
          ),
        ],
      ),
    );
  }
}
