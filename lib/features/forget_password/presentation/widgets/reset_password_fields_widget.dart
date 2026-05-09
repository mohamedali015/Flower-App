import 'package:flower_app/core/helpers/my_responsive.dart';
import 'package:flower_app/core/utils/app_colors.dart';
import 'package:flower_app/core/values/app_strings.dart';
import 'package:flutter/material.dart';

import '../../../../../core/helpers/validator.dart';
import '../../../../../core/localization/l10n/app_localizations.dart';

class ResetPasswordFieldsWidget extends StatefulWidget {
  const ResetPasswordFieldsWidget({
    super.key,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.isLoading,
    required this.passwordFocus,
    required this.confirmPasswordFocus,
  });

  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final FocusNode passwordFocus;
  final FocusNode confirmPasswordFocus;
  final bool isLoading;

  @override
  State<ResetPasswordFieldsWidget> createState() =>
      _ResetPasswordFieldsWidgetState();
}

class _ResetPasswordFieldsWidgetState extends State<ResetPasswordFieldsWidget> {
  bool isPasswordHidden = true;

  bool isConfirmPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Column(
      children: [
        TextFormField(
          controller: widget.passwordController,
          obscureText: isPasswordHidden,
          enabled: !widget.isLoading,
          validator: Validator.password,
          keyboardType: TextInputType.visiblePassword,
          focusNode: widget.passwordFocus,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (_) {
            FocusScope.of(context).requestFocus(widget.confirmPasswordFocus);
          },
          decoration: InputDecoration(
            labelText: AppStrings.newPassword,
            hintText: AppStrings.enterYouPassword,
            suffixIcon: IconButton(
              icon: Icon(
                isPasswordHidden ? Icons.visibility : Icons.visibility_off,
                color: AppColors.grayDark,
              ),
              onPressed: () {
                setState(() {
                  isPasswordHidden = !isPasswordHidden;
                });
              },
            ),
          ),
        ),

        SizedBox(height: MyResponsive.height(context, value: 24)),

        TextFormField(
          controller: widget.confirmPasswordController,
          obscureText: isConfirmPasswordHidden,
          enabled: !widget.isLoading,
          validator: (value) =>
              Validator.confirmPassword(value, widget.passwordController.text),
          keyboardType: TextInputType.visiblePassword,
          focusNode: widget.confirmPasswordFocus,
          textInputAction: TextInputAction.done,

          onFieldSubmitted: (_) {
            FocusScope.of(context).unfocus();
          },
          decoration: InputDecoration(
            labelText: AppStrings.confirmPassword,
            hintText: AppStrings.enterYouPassword,
            suffixIcon: IconButton(
              icon: Icon(
                isConfirmPasswordHidden
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: AppColors.grayDark,
              ),
              onPressed: () {
                setState(() {
                  isConfirmPasswordHidden = !isConfirmPasswordHidden;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
