import 'package:flower_app/config/route_manager/routes.dart';
import 'package:flower_app/core/shared_widgets/custom_bottom_nav.dart';
import 'package:flower_app/feautre/cart/presentation/screens/cart_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/values/app_strings.dart';
import '../../feautre/category/presentation/screens/category_screen.dart';
import '../../feautre/home/presentation/screens/home_screen.dart';
import '../../feautre/profile/presentation/screens/profile_screen.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      /// Splash Screen
      // case Routes.splashRoute:
      //   return CupertinoPageRoute(builder: (_) =>  SplashScreen());
      case Routes.homeRoute:
        return CupertinoPageRoute(builder: (_) => HomeScreen());
      case Routes.categoryRoute:
        return CupertinoPageRoute(builder: (_) => CategoryScreen());
      case Routes.cartRoute:
        return CupertinoPageRoute(builder: (_) => CartScreen());
      case Routes.profileRoute:
        return CupertinoPageRoute(builder: (_) => ProfileScreen());
      case Routes.bottomNavBarRoute:
        return CupertinoPageRoute(builder: (_) => CustomBottomNavBar());

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
