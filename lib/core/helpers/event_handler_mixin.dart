import 'package:flutter/cupertino.dart';

import '../../config/base_cubit/base_event.dart';
import 'app_snack_bar.dart';

mixin EventHandlerMixin<T extends StatefulWidget> on State<T> {
  void handleEvent(BaseEvent event) {
    switch (event) {
      case DisplayErrorEvent():
        AppSnackBar.error(context, event.errorMsg);

      case DisplaySuccessEvent():
        AppSnackBar.success(context, event.successMsg);

      case NavigationEvent():
        {
          switch (event.type) {
            case NavigationType.push:
              Navigator.pushNamed(
                context,
                event.routeName,
                arguments: event.arguments,
              );

            case NavigationType.pushReplacement:
              Navigator.pushReplacementNamed(
                context,
                event.routeName,
                arguments: event.arguments,
              );

            case NavigationType.pushReplacementAndRemoveUntil:
              Navigator.pushNamedAndRemoveUntil(
                context,
                event.routeName,
                (route) => false,
                arguments: event.arguments,
              );

            case NavigationType.pop:
              Navigator.pop(context);

            case NavigationType.popUntil:
              Navigator.popUntil(context, ModalRoute.withName(event.routeName));
          }
        }
    }
  }
}
