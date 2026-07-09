import 'package:flower_app/core/localization/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../../../core/shared_widgets/svg_wrapper.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

class ContactAddressCard extends StatelessWidget {
  const ContactAddressCard({
    super.key,
    required this.imageUrl,
    required this.name,
    this.onCallPressed,
    this.onWhatsappPressed,
  });

  final String imageUrl;
  final String name;
  final VoidCallback? onCallPressed;
  final VoidCallback? onWhatsappPressed;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const SvgWrapper(
            path: AppAssets.driverBoyIcon,
            width: 36,
            height: 36,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.medium14(
                    context,
                  ).copyWith(color: AppColors.darkBase),
                ),
                const SizedBox(height: 4),
                Text(
                  localizations.isYourDeliveryHeroForToday,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.medium12(
                    context,
                  ).copyWith(color: AppColors.grayDark),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Row(
            children: [
              InkWell(
                onTap: onCallPressed,
                child: const Icon(
                  Icons.call_outlined,
                  size: 24,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(width: 16),
              InkWell(
                onTap: onWhatsappPressed,
                child: const SvgWrapper(
                  path: AppAssets.whatsAppIcon,
                  width: 24,
                  height: 24,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
