import 'package:flower_app/config/route_manager/routes.dart';
import 'package:flower_app/features/auth/presentation/pages/register/register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/shared_widgets/custom_bottom_nav.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/values/app_strings.dart';
import '../../features/auth/presentation/manager/login/login_cubit.dart';
import '../../features/auth/presentation/manager/register_cubit.dart';
import '../../features/auth/presentation/pages/login/login_screen.dart';
import '../../features/cart/presentation/screens/cart_screen.dart';
import '../../features/category/presentation/screens/category_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../di/di.dart';
import '../../features/forget_password/presentation/manager/cubit/forget_password_cubit.dart';
import '../../features/forget_password/presentation/pages/forget_password_enter_email_view.dart';
import '../di/di.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    try {
      switch (settings.name) {
        /// Login Screen
        case Routes.loginRoute:
          return CupertinoPageRoute(
            builder: (_) => BlocProvider(
              create: (context) => getIt<LoginCubit>(),
              child: const LoginScreen(),
            ),
          );

      /// Register Screen
      case Routes.registerRoute:
        return CupertinoPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<RegisterCubit>(),
            child: const RegisterScreen(),
          ),
        );

    /// Forget Password - Enter Email
      case Routes.forgetPasswordEnterEmailViewRoute:
        return CupertinoPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<ForgetPasswordCubit>(),
            child: const ForgetPasswordEnterEmailView(),
          ),
        );


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

        /// Default
        default:
          return _errorRoute();
      }
    } catch (e, stackTrace) {
      debugPrint("Route error: $e");
      debugPrint("$stackTrace");

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
