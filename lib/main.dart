import 'package:flower_app/core/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'config/di/di.dart';
import 'config/route_manager/route_generator.dart';
import 'config/route_manager/routes.dart';
import 'config/user/manager/user_cubit.dart';
import 'config/user/manager/user_state.dart';
import 'core/helpers/custom_bloc_observer.dart';
import 'core/helpers/show_session_expired_dialog.dart';
import 'core/localization/l10n/app_localizations.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies();

  Bloc.observer = CustomBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<UserCubit>(),
      child: Builder(
        builder: (context) {
          return MaterialApp(
            navigatorKey: AppConstants.navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'Flower APP',

            initialRoute: Routes.splashRoute,
            onGenerateRoute: RouteGenerator.getRoute,
            locale: const Locale("en"),
            theme: AppTheme.appTheme(context),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            builder: (context, child) {
              return BlocListener<UserCubit, UserState>(
                listener: (context, state) {
                  if (state.isUnauthorized) {
                    showSessionExpiredDialog();
                  }
                },
                child: child!,
              );
            },
          );
        },
      ),
    );
  }
}
