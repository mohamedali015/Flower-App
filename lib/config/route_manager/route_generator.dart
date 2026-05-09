import 'package:flower_app/config/route_manager/routes.dart';
import 'package:flower_app/features/forget_password/presentation/manager/event/forget_password_event.dart';
import 'package:flower_app/features/forget_password/presentation/pages/verify_code.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/values/app_strings.dart';
import '../../features/forget_password/presentation/manager/cubit/forget_password_cubit.dart';
import '../../features/forget_password/presentation/pages/forget_password_enter_email_view.dart';
import '../di/di.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
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
        return CupertinoPageRoute(
          builder: (_) => BlocProvider.value(
            value: cubit..doEvent(ResendCodeTimer()),
            child: VerifyCode(),
          ),
        );

      /*
      /// New Password View
        case Routes.forgetPasswordNewPassViewRoute:
          final cubit = settings.arguments as ForgetPasswordCubit;
          return CupertinoPageRoute(
            builder: (_) => BlocProvider.value(
              value: cubit,
              child: const ForgetPasswordNewPasswordView(),
            ),
          );*/
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
