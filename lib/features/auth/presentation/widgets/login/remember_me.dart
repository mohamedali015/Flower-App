import 'package:flower_app/config/route_manager/routes.dart';
import 'package:flower_app/core/localization/l10n/app_localizations.dart';
import 'package:flower_app/core/utils/app_colors.dart';
import 'package:flower_app/features/auth/presentation/manager/login/login_cubit.dart';
import 'package:flutter/material.dart';

class RememberMe extends StatelessWidget {
  const RememberMe({
    super.key,
    required this.rememberMe,
    required this.cubit,
    required this.local,
  });

  final bool rememberMe;
  final LoginCubit cubit;
  final AppLocalizations local;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: rememberMe,
              onChanged: (value) {
                cubit.changeRememberMe(value ?? false);
              },
            ),
            Text(local.rememberMe),
          ],
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              Routes.forgetPasswordEnterEmailViewRoute,
            );
          },
          child: Text(
            local.forgetPassword,
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: AppColors.darkBase,
            ),
          ),
        ),
      ],
    );
  }
}
