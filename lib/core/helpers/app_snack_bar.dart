import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

abstract class AppSnackBar {
  static void error(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          // style: AppTextStyles.regular16().copyWith(color: AppColors.baseWhite),
        ),
        // backgroundColor: AppColors.error,
        duration: const Duration(seconds: 5),
      ),
    );
  }

  static void success(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          // style: AppTextStyles.regular16().copyWith(color: AppColors.baseWhite),
        ),
        // backgroundColor: AppColors.success,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}