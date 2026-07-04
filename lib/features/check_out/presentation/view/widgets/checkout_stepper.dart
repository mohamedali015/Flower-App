import 'package:flower_app/core/utils/app_colors.dart';
import 'package:flower_app/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import '../../../../../core/localization/l10n/app_localizations.dart';

class CheckoutStepper extends StatelessWidget {
  const CheckoutStepper({super.key, required this.currentStep});

  final int currentStep;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Container(
      color: AppColors.background,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Row(
              children: [
                _circle(1, currentStep >= 0, context),
                _line(currentStep >= 1),
                _circle(2, currentStep >= 1, context),
                _line(currentStep >= 2),
                _circle(3, currentStep >= 2, context),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(local.address),
                Text(local.payment),
                Text(local.trackOrder),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _line(bool active) {
    return Expanded(
      child: Container(
        height: 3,
        color: active ? AppColors.primaryColor : AppColors.grayLight,
      ),
    );
  }

  Widget _circle(int number, bool active, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active ? AppColors.primaryColor : AppColors.background,
        border: Border.all(
          color: active ? AppColors.primaryColor : AppColors.grayLight,
          width: 2.5,
        ),
      ),
      child: Text(
        '$number',
        style: AppTextStyles.regular16(
          context,
        ).copyWith(color: active ? AppColors.background : AppColors.grayDark),
      ),
    );
  }
}
