import 'package:flutter/material.dart';

import '../helpers/my_responsive.dart';

abstract class AppTextStyles {
  static TextStyle _base(
    BuildContext context, {
    required double size,
    required FontWeight weight,
  }) {
    return TextStyle(
      fontSize: MyResponsive.fontSize(value: size, context),
      fontWeight: weight,
    );
  }

  static TextStyle regular10(BuildContext context) =>
      _base(context, size: 10, weight: FontWeight.w400);

  static TextStyle regular12(BuildContext context) =>
      _base(context, size: 12, weight: FontWeight.w400);

  static TextStyle regular13(BuildContext context) =>
      _base(context, size: 13, weight: FontWeight.w400);

  static TextStyle regular14(BuildContext context) =>
      _base(context, size: 14, weight: FontWeight.w400);

  static TextStyle regular16(BuildContext context) =>
      _base(context, size: 16, weight: FontWeight.w400);

  static TextStyle regular18(BuildContext context) =>
      _base(context, size: 18, weight: FontWeight.w400);

  static TextStyle regular20(BuildContext context) =>
      _base(context, size: 20, weight: FontWeight.w400);

  ///?   Medium  (FontWeight.w500)

  static TextStyle medium10(BuildContext context) =>
      _base(context, size: 10, weight: FontWeight.w500);

  static TextStyle medium12(BuildContext context) =>
      _base(context, size: 12, weight: FontWeight.w500);

  static TextStyle medium13(BuildContext context) =>
      _base(context, size: 13, weight: FontWeight.w500);

  static TextStyle medium14(BuildContext context) =>
      _base(context, size: 14, weight: FontWeight.w500);

  static TextStyle medium16(BuildContext context) =>
      _base(context, size: 16, weight: FontWeight.w500);

  static TextStyle medium18(BuildContext context) =>
      _base(context, size: 18, weight: FontWeight.w500);

  static TextStyle medium20(BuildContext context) =>
      _base(context, size: 20, weight: FontWeight.w500);

  static TextStyle medium24(BuildContext context) =>
      _base(context, size: 24, weight: FontWeight.w500);

  ///?  SemiBold  (FontWeight.w600)

  static TextStyle semiBold12(BuildContext context) =>
      _base(context, size: 12, weight: FontWeight.w600);

  static TextStyle semiBold14(BuildContext context) =>
      _base(context, size: 14, weight: FontWeight.w600);

  static TextStyle semiBold16(BuildContext context) =>
      _base(context, size: 16, weight: FontWeight.w600);

  static TextStyle semiBold18(BuildContext context) =>
      _base(context, size: 18, weight: FontWeight.w600);

  static TextStyle semiBold20(BuildContext context) =>
      _base(context, size: 20, weight: FontWeight.w600);

  static TextStyle semiBold24(BuildContext context) =>
      _base(context, size: 24, weight: FontWeight.w600);

  ///?  Bold  (FontWeight.w700)

  static TextStyle bold12(BuildContext context) =>
      _base(context, size: 12, weight: FontWeight.w700);

  static TextStyle bold14(BuildContext context) =>
      _base(context, size: 14, weight: FontWeight.w700);

  static TextStyle bold16(BuildContext context) =>
      _base(context, size: 16, weight: FontWeight.w700);

  static TextStyle bold18(BuildContext context) =>
      _base(context, size: 18, weight: FontWeight.w700);

  static TextStyle bold20(BuildContext context) =>
      _base(context, size: 20, weight: FontWeight.w700);

  static TextStyle bold24(BuildContext context) =>
      _base(context, size: 24, weight: FontWeight.w700);

  static TextStyle bold32(BuildContext context) =>
      _base(context, size: 32, weight: FontWeight.w700);
}
