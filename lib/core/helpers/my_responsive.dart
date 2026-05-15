import 'package:flutter/material.dart';

abstract class MyResponsive {
  /// Base design size
  static const double _baseWidth = 375;
  static const double _baseHeight = 812;

  /// Cache MediaQueryData (optional optimization)
  static Size _media(BuildContext context) => MediaQuery.sizeOf(context);

  /// Get font scale factor based on platform
  static double _getScaleFactor(BuildContext context) {
    double width = _media(context).width;

    /// Mobile
    if (width < 600) {
      return width / 400;
    }
    /// Tablet
    else if (width < 900) {
      return width / 700;
    }
    /// Desktop
    else {
      return width / 1000;
    }
  }

  /// Width scale
  static double width(BuildContext context, {required double value}) {
    final screenWidth = _media(context).width;
    return (value / _baseWidth) * screenWidth;
  }

  /// Height scale
  static double height(BuildContext context, {required double value}) {
    final screenHeight = _media(context).height;
    return (value / _baseHeight) * screenHeight;
  }

  /// Font size (respects user settings)
  static double fontSize(BuildContext context, {required double value}) {
    final scaleFactor = _getScaleFactor(context);
    double responsiveFont = value * scaleFactor;

    double lowerLimit = value * .8;
    double upperLimit = value * 1.2;

    return responsiveFont.clamp(lowerLimit, upperLimit);
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
      horizontal: width(context, value: horizontal ?? 0),
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
  static EdgeInsets paddingAll(BuildContext context, {required double value}) {
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
