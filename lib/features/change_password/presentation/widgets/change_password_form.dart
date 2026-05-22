import 'package:flower_app/core/helpers/my_responsive.dart';
import 'package:flower_app/core/helpers/validator.dart';
import 'package:flower_app/core/localization/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ChangePasswordForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController newPasswordController;
  final TextEditingController passwordController;
  final bool autoValidate;
  final VoidCallback onChanged;
  final AppLocalizations local;
  final bool isLoading;
  final FocusNode newPasswordFocus;
  final FocusNode confirmPasswordFocus;

  const ChangePasswordForm({
    super.key,
    required this.formKey,
    required this.confirmPasswordFocus,
    required this.newPasswordFocus,
    required this.newPasswordController,
    required this.passwordController,
    required this.autoValidate,
    required this.isLoading,
    required this.local,
    required this.onChanged,
  });

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      autovalidateMode: widget.autoValidate
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      child: Column(
        children: [
          TextFormField(
            enabled: !widget.isLoading,
            controller: widget.passwordController,
            validator: Validator.password,
            keyboardType: TextInputType.visiblePassword,
            onChanged: (_) => widget.onChanged(),
            decoration: InputDecoration(
              labelText: widget.local.currentPassword,
              hintText: widget.local.currentPassword,
            ),
          ),

          SizedBox(height: MyResponsive.height(context, value: 18)),

          TextFormField(
            controller: widget.newPasswordController,
            enabled: !widget.isLoading,
            validator: Validator.password,
            keyboardType: TextInputType.visiblePassword,
            focusNode: widget.newPasswordFocus,
            textInputAction: TextInputAction.next,
            onChanged: (_) => widget.onChanged(),
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(widget.confirmPasswordFocus);
            },
            decoration: InputDecoration(
              labelText: widget.local.newPassword,
              hintText: widget.local.newPassword,
            ),
          ),

          SizedBox(height: MyResponsive.height(context, value: 18)),

          TextFormField(
            enabled: !widget.isLoading,
            validator: (value) => Validator.confirmPassword(
              value,
              widget.newPasswordController.text,
            ),
            keyboardType: TextInputType.visiblePassword,
            focusNode: widget.confirmPasswordFocus,
            textInputAction: TextInputAction.done,
            onChanged: (_) => widget.onChanged(),
            decoration: InputDecoration(
              labelText: widget.local.confirmPassword,
              hintText: widget.local.confirmPasswordHint,
            ),
          ),
        ],
      ),
    );
  }
}
