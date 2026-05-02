import 'package:flutter/material.dart';
import '../helpers/my_responsive.dart';

abstract class AppTextStyles {
  // =========================
  // Regular (FontWeight.w400)
  // =========================

  static TextStyle regular12(BuildContext context) {
    return TextStyle(
      fontSize: MyResponsive.fontSize(value: 12, context),
      fontWeight: FontWeight.w400,
    );
  }

  // =========================
  // Medium (FontWeight.w500)
  // =========================

  static TextStyle medium12(BuildContext context) {
    return TextStyle(
      fontSize: MyResponsive.fontSize(value: 12, context),
      fontWeight: FontWeight.w500,
    );
  }

  // =========================
  // SemiBold (FontWeight.w600)
  // =========================

  static TextStyle semiBold12(BuildContext context) {
    return TextStyle(
      fontSize: MyResponsive.fontSize(value: 12, context),
      fontWeight: FontWeight.w600,
    );
  }

  // =========================
  // Bold (FontWeight.w700)
  // =========================

  static TextStyle bold16(BuildContext context) {
    return TextStyle(
      fontSize: MyResponsive.fontSize(value: 16, context),
      fontWeight: FontWeight.w700,
    );
  }
}
