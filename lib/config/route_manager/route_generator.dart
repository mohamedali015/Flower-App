import 'package:flower_app/config/add_to_cart/presentation/manager/add_cart_cubit.dart';
import 'package:flower_app/config/di/di.dart';
import 'package:flower_app/config/products/domain/entities/product_entity.dart';
import 'package:flower_app/config/route_manager/routes.dart';
import 'package:flower_app/features/about_us/presentation/screens/about_us_screen.dart';
import 'package:flower_app/features/auth/presentation/manager/register/register_cubit.dart';
import 'package:flower_app/features/auth/presentation/pages/register/register_screen.dart';
import 'package:flower_app/features/best_seller/presentation/pages/best_seller_screen.dart';
import 'package:flower_app/features/edit_profile/presentation/manager/edit_profile_cubit.dart';
import 'package:flower_app/features/edit_profile/presentation/pages/edit_profile_screen.dart';
import 'package:flower_app/features/change_password/presentation/manager/cubit/change_password_cubit.dart';
import 'package:flower_app/features/change_password/presentation/screens/change_password_screen.dart';
import 'package:flower_app/features/logout/presentation/manager/cubit/logout_cubit.dart';
import 'package:flower_app/features/home/presentation/manager/cubit/home_cubit.dart';
import 'package:flower_app/features/home/presentation/manager/cubit/home_events.dart';
import 'package:flower_app/features/occasions/presentation/manager/occasions_cubit.dart';
import 'package:flower_app/features/occasions/presentation/manager/occasions_events.dart';
import 'package:flower_app/features/occasions/presentation/pages/occasion_screen.dart';
import 'package:flower_app/features/product_details/presentation/pages/product_details_screen.dart';
import 'package:flower_app/features/terms_and_conditions/presentation/screens/terms_and_conditions_screen.dart';
import 'package:flower_app/features/search/presentation/manager/search_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/shared_widgets/custom_bottom_nav.dart';
import '../../core/values/app_strings.dart';
import '../../features/auth/presentation/manager/login/login_cubit.dart';
import '../../features/auth/presentation/pages/login/login_screen.dart';
import '../../features/best_seller/presentation/manager/best_seller_cubit.dart';
import '../../features/best_seller/presentation/manager/best_seller_event.dart';
import '../../features/cart/presentation/manager/cart_cubit.dart';
import '../../features/cart/presentation/manager/cart_event.dart';
import '../../features/check_out/presentation/view/screen/check_out_screen.dart';
import '../../features/check_out/presentation/manager/checkout_cubit.dart';
import '../../features/forget_password/presentation/manager/cubit/forget_password_cubit.dart';
import '../../features/forget_password/presentation/manager/event/forget_password_event.dart';
import '../../features/forget_password/presentation/pages/forget_password_enter_email_view.dart';
import '../../features/forget_password/presentation/pages/reset_password.dart';
import '../../features/forget_password/presentation/pages/verify_code.dart';
import '../../features/search/presentation/screens/search_screen.dart';
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
              child: const ForgetPasswordEnterEmailView(),
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

        case Routes.bottomNavBarRoute:
          final args = settings.arguments as Map<String, dynamic>?;

          return CupertinoPageRoute(
            builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) =>
                      getIt<HomeCubit>()..doEvents(GetHomeEvent()),
                ),

                BlocProvider(
                  create: (context) =>
                      getIt<CartCubit>()..doEvent(GetCartItemsEvent()),
                ),
              ],

              child: CustomBottomNavBar(
                initialIndex: args?['initialIndex'] ?? 0,
                categoryIndex: args?['categoryIndex'] ?? 0,
              ),
            ),
          );

        case Routes.bestSellerRoute:
          return CupertinoPageRoute(
            builder: (_) => BlocProvider(
              create: (context) =>
                  getIt<BestSellerCubit>()..doEvent(GetBestSellerEvent()),
              child: const BestSellerScreen(),
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
          final entity = settings.arguments as ProductEntity;

          return CupertinoPageRoute(
            builder: (_) => BlocProvider.value(
              value: getIt<CartCubit>(),
              child: ProductDetailsScreen(entity: entity),
            ),
          );

        case Routes.changePasswordRoute:
          return CupertinoPageRoute(
            builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => getIt<ChangePasswordCubit>()),
                BlocProvider(create: (context) => getIt<LogoutCubit>()),
              ],
              child: const ChangePasswordScreen(),
            ),
          );

        ///? search Screen
        case Routes.searchScreenRoute:
          return CupertinoPageRoute(
            builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => getIt<SearchCubit>()),
                BlocProvider(create: (context) => getIt<AddCartCubit>()),
                BlocProvider(
                  create: (_) => getIt<CartCubit>(),
                ),
              ],
              child: const SearchScreen(),
            ),
          );

        case Routes.editProfileScreenRoute:
          return CupertinoPageRoute(
            builder: (_) => BlocProvider(
              create: (context) => getIt<EditProfileCubit>(),
              child: const EditProfileScreen(),
            ),
          );
        case Routes.termsAndConditionsRoute:
          return CupertinoPageRoute(
            builder: (_) => const TermsAndConditionsScreen(),
          );

        case Routes.aboutUsRoute:
          return CupertinoPageRoute(builder: (_) => const AboutUsScreen());

        ////? Check out
        case Routes.checkOutRoute:
          return CupertinoPageRoute(
            builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider<CartCubit>(
                  create: (context) =>
                      getIt<CartCubit>()..doEvent(GetCartItemsEvent()),
                ),
                BlocProvider<CheckoutCubit>(
                  create: (context) => getIt<CheckoutCubit>(),
                ),
              ],
              child: const CheckOutScreen(),
            ),
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
