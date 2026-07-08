import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/shared_widgets/svg_wrapper.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../domain/entities/firestore_notification_entity.dart'; // استيراد الـ Entity الجديد

class NotificationListViewItem extends StatelessWidget {
  final FirestoreNotificationEntity entity; // تعديل النوع هنا ليكون الجديد

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
