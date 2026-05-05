import 'package:flower_app/config/secure_cache/secure_cache/cache_keys.dart';
import 'package:flower_app/config/secure_cache/secure_cache/secure_cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'config/di/di.dart';
import 'config/local_storage/local_storage.dart';
import 'config/route_manager/route_generator.dart';
import 'config/route_manager/routes.dart';
import 'core/helpers/custom_bloc_observer.dart';
import 'core/localization/l10n/app_localizations.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies();

  await getIt<LocalStorage>().init();

  final token = await SecureCacheHelper.getData(key: CacheKeys.token);

  final rememberMeString = await SecureCacheHelper.getData(
    key: CacheKeys.rememberMe,
  );

  final bool rememberMe = rememberMeString == 'true';
  Bloc.observer = CustomBlocObserver();

  runApp(MyApp(token: token, rememberMe: rememberMe));
}

class MyApp extends StatelessWidget {
  final String? token;
  final bool rememberMe;

  const MyApp({super.key, required this.token, required this.rememberMe});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flower APP',

      initialRoute: (token != null && rememberMe)
          ? Routes.homeRoute
          : Routes.loginRoute,
      onGenerateRoute: RouteGenerator.getRoute,
      locale: const Locale("en"),
      theme: AppTheme.appTheme(context),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
