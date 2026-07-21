sealed class BaseEvent {
  const BaseEvent();
}

class DisplayErrorEvent extends BaseEvent {
  final String errorMsg;

  const DisplayErrorEvent({required this.errorMsg});
}

class DisplaySuccessEvent extends BaseEvent {
  final String successMsg;

  const DisplaySuccessEvent({required this.successMsg});
}

class NavigationEvent extends BaseEvent {
  final String routeName;
  final NavigationType type;
  final Object? arguments;

  const NavigationEvent({
    required this.routeName,
    required this.type,
    this.arguments,
  });
}

enum NavigationType {
  push,
  pushReplacement,
  pushReplacementAndRemoveUntil,
  pop,
  popUntil,
}
