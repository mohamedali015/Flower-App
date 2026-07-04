import 'package:flutter/cupertino.dart';

import '../../../../core/shared_widgets/svg_wrapper.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../domain/entities/notification_entity.dart';

class NotificationListViewItem extends StatelessWidget {
  final NotificationEntity entity;

  const NotificationListViewItem({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SvgWrapper(
          path: AppAssets.notification,
          width: 16,
          height: 16,
          color: AppColors.grayDark,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(entity.title, style: AppTextStyles.medium16(context)),
              const SizedBox(height: 8),
              Text(
                entity.body,
                style: AppTextStyles.regular12(
                  context,
                ).copyWith(color: AppColors.grayDark),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
