import 'package:flower_app/config/di/di.dart';
import 'package:flower_app/config/route_manager/routes.dart';
import 'package:flower_app/features/auth/presentation/manager/login/login_cubit.dart';
import 'package:flower_app/features/auth/presentation/pages/register/register_screen.dart';
import 'package:flower_app/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/values/app_strings.dart';
import '../../features/auth/presentation/pages/login/login_screen.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      /// Splash Screen
      // case Routes.splashRoute:
      //   return CupertinoPageRoute(builder: (_) => const SplashScreen());

      /// Login Screen
      case Routes.loginRoute:
        return CupertinoPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: LoginScreen(),
          ),
        );

      /// Register Screen
      case Routes.registerRoute:
        return CupertinoPageRoute(builder: (_) => const RegisterScreen());

      case Routes.homeRoute:
        return CupertinoPageRoute(builder: (_) => const HomeScreen());

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
