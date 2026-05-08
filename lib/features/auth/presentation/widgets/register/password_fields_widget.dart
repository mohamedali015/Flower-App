import 'package:flower_app/core/helpers/my_responsive.dart';
import 'package:flower_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../../core/helpers/validator.dart';
import '../../../../../core/localization/l10n/app_localizations.dart';

class PasswordFieldsWidget extends StatefulWidget {
  const PasswordFieldsWidget({
    super.key,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.isLoading,
  });

  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool isLoading;

  @override
  State<PasswordFieldsWidget> createState() => _PasswordFieldsWidgetState();
}

class _PasswordFieldsWidgetState extends State<PasswordFieldsWidget> {
  bool isPasswordHidden = true;

  bool isConfirmPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TextFormField(
            controller: widget.passwordController,
            obscureText: isPasswordHidden,
            enabled: !widget.isLoading,
            validator: Validator.password,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              labelText: local.password,
              hintText: local.enterPassword,
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
        ),

        SizedBox(width: MyResponsive.width(context, value: 16)),

        Expanded(
          child: TextFormField(
            controller: widget.confirmPasswordController,
            obscureText: isConfirmPasswordHidden,
            enabled: !widget.isLoading,
            validator: (value) => Validator.confirmPassword(
              value,
              widget.passwordController.text,
            ),
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
                onPressed: () {
                  setState(() {
                    isConfirmPasswordHidden = !isConfirmPasswordHidden;
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
