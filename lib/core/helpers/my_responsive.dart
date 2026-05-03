import 'package:flutter/material.dart';

abstract class MyResponsive {
  /// Base design size
  static const double _baseWidth = 375;
  static const double _baseHeight = 812;

  /// Cache MediaQueryData (optional optimization)
  static MediaQueryData _media(BuildContext context) =>
      MediaQuery.of(context);

  /// Width scale
  static double width(BuildContext context, {required double value}) {
    final screenWidth = _media(context).size.width;
    return (value / _baseWidth) * screenWidth;
  }

  /// Height scale
  static double height(BuildContext context, {required double value}) {
    final screenHeight = _media(context).size.height;
    return (value / _baseHeight) * screenHeight;
  }

  /// Font size (respects user settings)
  static double fontSize(BuildContext context, {required double value}) {
    final scale = _media(context).textScaleFactor;
    return width(context, value: value) / scale;
  }

  /// Radius
  static double radius(BuildContext context, {required double value}) {
    return width(context, value: value);
  }

  /// Padding symmetric
  static EdgeInsets paddingSymmetric(
      BuildContext context, {
        double? horizontal,
        double? vertical,
      }) {
    return EdgeInsets.symmetric(
      horizontal: width(context, value: horizontal ?? 0 ),
      vertical: height(context, value: vertical ?? 0),
    );
  }

  /// Padding only
  static EdgeInsetsDirectional paddingOnly(
      BuildContext context, {
        double? start,
        double? end,
        double? top,
        double? bottom,
      }) {
    return EdgeInsetsDirectional.only(
      start: width(context, value: start ?? 0),
      end: width(context, value: end ?? 0),
      top: height(context, value: top ?? 0),
      bottom: height(context, value: bottom ?? 0),
    );
  }

  /// Padding all
  static EdgeInsets paddingAll(
      BuildContext context, {
        required double value,
      }) {
    return EdgeInsets.all(width(context, value: value));
  }
}


///?  How to use
/*


SizedBox(
  width: MyResponsive.width(context, value: 30),
  height: MyResponsive.height(context, value: 30),
);

Text(
  "Hello",
  style: TextStyle(
    fontSize: MyResponsive.fontSize(context, value: 16),
  ),
);

Container(
  padding: MyResponsive.paddingSymmetric(
    context,
    horizontal: 16,
    vertical: 12,
  ),
);

 */