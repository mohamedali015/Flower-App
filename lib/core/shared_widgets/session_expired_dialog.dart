import 'package:flutter/material.dart';
import '../../config/route_manager/routes.dart';
import '../utils/app_constants.dart';
import '../values/app_strings.dart';
import 'custom_button.dart';

class SessionExpiredDialog extends StatelessWidget {
  const SessionExpiredDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(AppStrings.sessionExpired),
      content: const Text(AppStrings.pleaseLoginAgain),
      actions: [
        CustomButton(
          onPressed: () {
            AppConstants.navigatorKey.currentState!.pushNamedAndRemoveUntil(Routes.loginRoute, (route) => false,);
          },
          title: AppStrings.login,
        ),
      ],
    );
  }
}
