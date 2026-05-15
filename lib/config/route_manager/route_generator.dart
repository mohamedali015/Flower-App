import 'package:flower_app/config/di/di.dart';
import 'package:flower_app/config/products/domain/entities/product_entity.dart';
import 'package:flower_app/config/route_manager/routes.dart';
import 'package:flower_app/features/auth/presentation/manager/register/register_cubit.dart';
import 'package:flower_app/features/auth/presentation/pages/register/register_screen.dart';
import 'package:flower_app/features/best_seller/presentation/pages/best_seller_screen.dart';
import 'package:flower_app/features/occasions/presentation/manager/occasions_cubit.dart';
import 'package:flower_app/features/occasions/presentation/manager/occasions_events.dart';
import 'package:flower_app/features/occasions/presentation/pages/occasion_screen.dart';
import 'package:flower_app/features/product_details/presentation/pages/product_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/shared_widgets/custom_bottom_nav.dart';
import '../../core/values/app_strings.dart';
import '../../features/auth/presentation/manager/login/login_cubit.dart';
import '../../features/auth/presentation/pages/login/login_screen.dart';
import '../../features/best_seller/presentation/manager/best_seller_cubit.dart';
import '../../features/best_seller/presentation/manager/best_seller_event.dart';
import '../../features/cart/presentation/screens/cart_screen.dart';
import '../../features/category/presentation/screens/category_screen.dart';
import '../../features/forget_password/presentation/manager/cubit/forget_password_cubit.dart';
import '../../features/forget_password/presentation/manager/event/forget_password_event.dart';
import '../../features/forget_password/presentation/pages/forget_password_enter_email_view.dart';
import '../../features/forget_password/presentation/pages/reset_password.dart';
import '../../features/forget_password/presentation/pages/verify_code.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/splash/splash_screen.dart';

abstract class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    try {
      switch (settings.name) {
        /// Splash Screen
        case Routes.splashRoute:
          return CupertinoPageRoute(builder: (_) => const SplashScreen());

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
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) => getIt<ForgetPasswordCubit>(),
              child: ForgetPasswordEnterEmailView(),
            ),
          );

        /// OTP View
        case Routes.forgetPasswordOtpViewRoute:
          final cubit = settings.arguments as ForgetPasswordCubit;
          return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: cubit..doEvent(ResendCodeTimer()),
              child: const VerifyCode(),
            ),
          );

        /// New Password View
        case Routes.forgetPasswordNewPassViewRoute:
          final cubit = settings.arguments as ForgetPasswordCubit;
          return MaterialPageRoute(
            builder: (_) =>
                BlocProvider.value(value: cubit, child: const ResetPassword()),
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

        case Routes.bestSellerRoute:
          return CupertinoPageRoute(
            builder: (_) => BlocProvider(
              create: (context) =>
                  getIt<BestSellerCubit>()..doEvent(GetBestSellerEvent()),
              child: BestSellerScreen(),
            ),
          );

        case Routes.occasionRoute:
          final currentIndex = settings.arguments as int?;

          return CupertinoPageRoute(
            builder: (_) => BlocProvider(
              create: (context) =>
                  getIt<OccasionsCubit>()
                    ..doEvent(GetOccasionsCategoriesEvent()),
              child: OccasionScreen(currentIndex: currentIndex),
            ),
          );

        case Routes.productDetailsRoute:
          //final entity = settings.arguments as ProductEntity;
          return CupertinoPageRoute(
            builder: (_) => ProductDetailsScreen(entity: product),
          );

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
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(
          child: Text(AppStrings.pageNotFound, style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}

final product = ProductEntity(
  id: '1',
  title: 'Rose Bouquet',
  slug: 'rose-bouquet',
  description: 'Beautiful bouquet of fresh roses',
  imgCover:
      'https://flower.elevateegy.com/uploads/66c36d5d-c067-46d9-b339-d81be57e0149-image_one.png',
  images: [
    'https://flower.elevateegy.com/uploads/66c36d5d-c067-46d9-b339-d81be57e0149-image_one.png',
    'https://flower.elevateegy.com/uploads/f27e1903-74cf-4ed6-a42c-e43e35b6dd14-image_three.png',
    'https://flower.elevateegy.com/uploads/500fe197-0e16-4b01-9a0d-031ccb032714-image_two.png',
  ],
  price: 500,
  priceAfterDiscount: 450,
  discount: 10,
  rateAvg: 4.8,
  rateCount: 120,
  sold: 75,
  quantity: 20,
  category: 'Flowers',
  occasion: 'Birthday',
  isSuperAdmin: false,
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
  v: 0,
  favoriteId: '',
  isInWishlist: false,
);
