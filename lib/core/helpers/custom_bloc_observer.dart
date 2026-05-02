import 'package:flutter_bloc/flutter_bloc.dart';

import 'custom_logger.dart';

class CustomBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    CustomLogger.blue('onEvent -- ${bloc.runtimeType}, $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    CustomLogger.green('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    CustomLogger.yellow('onTransition -- ${bloc.runtimeType}, $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    CustomLogger.red('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    CustomLogger.bgWhite('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onClose(BlocBase bloc) {
    CustomLogger.bgWhite('onClose -- ${bloc.runtimeType}');
    super.onClose(bloc);
  }
}
