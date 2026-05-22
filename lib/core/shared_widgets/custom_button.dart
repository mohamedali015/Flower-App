import 'package:flutter/material.dart';
import '../helpers/my_responsive.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.radiusValue = 100,
    this.isLoading = false,
    this.titleStyle,
    this.borderColor,
  });

  final String title;
  final Color? borderColor;
  final TextStyle? titleStyle;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? radiusValue;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusValue!),
          side: BorderSide(
            color: onPressed == null || isLoading
                ? AppColors.disabledGray
                : borderColor ?? AppColors.primaryColor,
            width: MyResponsive.width(value: 1, context),
          ),
        ),
      ),
      child: isLoading
          ? SizedBox(
              height: MyResponsive.height(value: 22, context),
              width: MyResponsive.width(value: 22, context),
              child: CircularProgressIndicator(
                color: AppColors.baseWhite,
                strokeWidth: MyResponsive.width(value: 2, context),
              ),
            )
          : Text(
              title,
              style:
                  titleStyle ??
                  AppTextStyles.medium16(
                    context,
                  ).copyWith(color: foregroundColor),
            ),
    );
  }
}
