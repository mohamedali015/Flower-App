import 'package:flower_app/config/route_manager/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/values/app_strings.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {

      switch (settings.name) {
        /// Splash Screen
        // case Routes.splashRoute:
        //   return CupertinoPageRoute(builder: (_) =>  SplashScreen());


        /// Default (Unknown Route)
        default:
          return _errorRoute();
      }

  }

  static Route<dynamic> _errorRoute() {
    return CupertinoPageRoute(
      builder: (_) => const Scaffold(
        body: Center(
          child: Text(AppStrings.pageNotFound, style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}
