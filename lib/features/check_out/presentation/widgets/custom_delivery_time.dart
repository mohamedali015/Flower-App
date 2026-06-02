import 'package:flower_app/core/shared_widgets/svg_wrapper.dart';
import 'package:flower_app/core/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/localization/l10n/app_localizations.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_text_styles.dart';

class CustomDeliveryTime extends StatelessWidget {
  const CustomDeliveryTime({
    super.key,
    this.textArrive = "Arrive by 03 Sep 2024, 11:00 AM",
  });
  final String? textArrive;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 24),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            local.deliveryTime,
            style: AppTextStyles.medium18(
              context,
            ).copyWith(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              const SvgWrapper(
                path: AppAssets.schedule,
                height: 28,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 8),
              Text(
                local.instant,
                style: AppTextStyles.medium16(context).copyWith(
                  color: AppColors.darkBase,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                textArrive!,
                style: AppTextStyles.medium16(context).copyWith(
                  color: AppColors.success,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
