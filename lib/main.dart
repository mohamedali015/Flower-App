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
  Bloc.observer = CustomBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flower APP',
      initialRoute: Routes.registerRoute,
      onGenerateRoute: RouteGenerator.getRoute,
      locale: Locale("en"),
      theme: AppTheme.appTheme(context),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
