import 'package:flower_app/core/helpers/my_responsive.dart';
import 'package:flower_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../../core/helpers/validator.dart';
import '../../../../../core/localization/l10n/app_localizations.dart';

class PasswordFieldsWidget extends StatelessWidget {
  const PasswordFieldsWidget({
    super.key,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.isLoading,
    required this.validationMode,
    required this.isPasswordHidden,
    required this.isConfirmPasswordHidden,
    required this.passwordSuffixOnTap,
    required this.confirmPasswordSuffixOnTap,
  });

  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool isLoading;
  final AutovalidateMode validationMode;
  final bool isPasswordHidden;
  final bool isConfirmPasswordHidden;
  final VoidCallback passwordSuffixOnTap;
  final VoidCallback confirmPasswordSuffixOnTap;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child:
              /// Password
              TextFormField(
                controller: passwordController,
                obscureText: isPasswordHidden,
                enabled: !isLoading,
                validator: Validator.password,
                autovalidateMode: validationMode,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: local.password,
                  hintText: local.enterPassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordHidden
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: AppColors.grayDark,
                    ),
                    onPressed: passwordSuffixOnTap,
                  ),
                ),
              ),
        ),
        SizedBox(width: MyResponsive.width(context, value: 16)),
        Expanded(
          child:
              /// confirm Password
              TextFormField(
                controller: confirmPasswordController,
                obscureText: isConfirmPasswordHidden,
                enabled: !isLoading,
                validator: (value) =>
                    Validator.confirmPassword(value, passwordController.text),
                autovalidateMode: validationMode,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: local.confirmPassword,
                  hintText: local.confirmPasswordHint,
                  suffixIcon: IconButton(
                    icon: Icon(
                      isConfirmPasswordHidden
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: AppColors.grayDark,
                    ),
                    onPressed: confirmPasswordSuffixOnTap,
                  ),
                ),
              ),
        ),
      ],
    );
  }
}
