import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseCubit<State, UiEvent> extends Cubit<State> {
  BaseCubit(super.initialState);

  final StreamController<UiEvent> _eventController = StreamController();

  Stream<UiEvent> get eventStream => _eventController.stream;

  void emitEvent(UiEvent event) {
    if (_eventController.isClosed) {
      throw StateError('Cannot emit new events after calling close');
    }

    _eventController.add(event);
  }

  @override
  Future<void> close() {
    _eventController.close();
    return super.close();
  }
}
