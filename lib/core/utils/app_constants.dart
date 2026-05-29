import 'package:flutter/material.dart';

abstract class AppConstants {
  // static const String fontFamily = 'Cairo';
  static const paddingHorizontal = 16.0;
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static const String termsAndConditionsBaseUrl =
      'https://elevate-flutter-team.github.io/flower_app_web_views/terms.html';
}
