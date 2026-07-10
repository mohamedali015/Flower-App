import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flower_app/config/notification_services/notification_service.dart';
import 'package:flower_app/config/notification_services/save_user_info_service.dart';
import 'package:flower_app/core/utils/app_constants.dart';
import 'package:flower_app/features/notifications/presentation/manager/notifications_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/di/di.dart';
import 'config/route_manager/route_generator.dart';
import 'config/route_manager/routes.dart';
import 'config/user/manager/user_cubit.dart';
import 'core/cubit/locale/locale_cubit.dart';
import 'core/helpers/custom_bloc_observer.dart';
import 'core/localization/l10n/app_localizations.dart';
import 'core/theme/app_theme.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await setupFlutterNotifications();

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  /// main thread errors
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  /// platform specific errors (android & ios) & api requests errors
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  configureDependencies();

  Bloc.observer = CustomBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen(showFlutterNotification);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<UserCubit>()),

        BlocProvider(create: (_) => getIt<LocaleCubit>()),

        BlocProvider(create: (_) => getIt<NotificationsCubit>()),
      ],
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, locale) {
          return MaterialApp(
            navigatorKey: AppConstants.navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'Flower APP',

            initialRoute: Routes.splashRoute,
            onGenerateRoute: RouteGenerator.getRoute,

            locale: locale,

            theme: AppTheme.appTheme(context),

            localizationsDelegates: AppLocalizations.localizationsDelegates,

            supportedLocales: AppLocalizations.supportedLocales,

            builder: (context, child) {
              return BlocListener<LocaleCubit, Locale>(
                listener: (context, locale) {
                  final user = context.read<UserCubit>().state.user;

                  if (user != null) {
                    getIt<SaveUserInfoService>().updateUserLanguage(
                      userId: user.id,
                      language: locale.languageCode,
                    );
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
