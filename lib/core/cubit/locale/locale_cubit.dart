import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LocaleCubit extends Cubit<Locale> {

  
  LocaleCubit() : super(const Locale('en'));

  void changeLanguage(String code) {
    emit(Locale(code));
  }
}
