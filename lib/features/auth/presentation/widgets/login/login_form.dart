import 'package:flower_app/core/helpers/my_responsive.dart';
import 'package:flower_app/core/helpers/validator.dart';
import 'package:flower_app/core/localization/l10n/app_localizations.dart';
import 'package:flower_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool autoValidate;

  final VoidCallback onChanged;
  final AppLocalizations local;
  final bool isLoading;

  const LoginForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.autoValidate,
    required this.isLoading,
    required this.local,
    required this.onChanged,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      autovalidateMode: widget.autoValidate
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      child: Column(
        children: [
          /// Email
          TextFormField(
            enabled: !widget.isLoading,
            controller: widget.emailController,
            validator: Validator.email,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: widget.local.email,
              hintText: widget.local.enterEmail,
            ),
          ),

          SizedBox(height: MyResponsive.height(context, value: 18)),

          /// Password
          TextFormField(
            enabled: !widget.isLoading,
            controller: widget.passwordController,
            validator: Validator.password,
            keyboardType: TextInputType.visiblePassword,
            obscureText: isPasswordHidden,
            decoration: InputDecoration(
              labelText: widget.local.password,
              hintText: widget.local.enterPassword,
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
        ],
      ),
    );
  }
}
