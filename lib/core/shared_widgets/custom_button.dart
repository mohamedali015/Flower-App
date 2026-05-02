import 'package:flutter/material.dart';
import '../helpers/my_responsive.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.radiusValue = 100,
    this.isLoading = false,
  });

  final String title;
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
            // color: onPressed == null || isLoading
            //     ? AppColors.disabledGray : AppColors.primaryColor,
            width: MyResponsive.width(value: 1, context),
          ),
        ),
      ),
      child: isLoading
          ? SizedBox(
              height: MyResponsive.height(value: 22, context),
              width: MyResponsive.width(value: 22, context),
              child: CircularProgressIndicator(
                // color: AppColors.baseWhite,
                strokeWidth: MyResponsive.width(value: 2, context),
              ),
            )
          : Text(
              title,
              // style: AppTextStyles.medium16().copyWith(color: foregroundColor),
            ),
    );
  }
}
