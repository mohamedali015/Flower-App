import 'package:flutter/material.dart';
import '../../../../../core/localization/l10n/app_localizations.dart';
import '../../../../../core/shared_widgets/custom_button.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';

class CustomCheckoutButton extends StatelessWidget {
  const CustomCheckoutButton({
    super.key,
    required this.title,
    required this.onNext,
    this.validator,
    this.errorMessage,
  });

  final String title;
  final VoidCallback onNext;
  final bool Function()? validator;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return CustomButton(
      title: title,
      onPressed: () {

        if (validator != null) {

          final isValid = validator!();

          if (!isValid) {

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  errorMessage ?? local.invalidData,
                  style: AppTextStyles.medium16(context).copyWith(
                    color: AppColors.background,
                  ),
                ),
              ),
            );

            return;
          }
        }

        onNext();

      },
    );
  }
}