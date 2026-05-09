import 'package:flower_app/core/helpers/my_responsive.dart';
import 'package:flutter/material.dart';

import '../../../../../core/helpers/validator.dart';
import '../../../../../core/localization/l10n/app_localizations.dart';

class NameFieldsWidget extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final FocusNode firstNameFocus;
  final FocusNode lastNameFocus;
  final FocusNode emailFocus;
  final bool isLoading;

  const NameFieldsWidget({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.isLoading,
    required this.firstNameFocus,
    required this.lastNameFocus,
    required this.emailFocus,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TextFormField(
            controller: firstNameController,
            enabled: !isLoading,
            validator: Validator.name,
            keyboardType: TextInputType.name,
            focusNode: firstNameFocus,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(lastNameFocus);
            },
            decoration: InputDecoration(
              labelText: local.firstName,
              hintText: local.enterFirstName,
            ),
          ),
        ),
        SizedBox(width: MyResponsive.width(context, value: 16)),
        Expanded(
          child: TextFormField(
            controller: lastNameController,
            enabled: !isLoading,
            validator: Validator.name,
            keyboardType: TextInputType.name,
            focusNode: lastNameFocus,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(emailFocus);
            },
            decoration: InputDecoration(
              labelText: local.lastName,
              hintText: local.enterLastName,
            ),
          ),
        ),
      ],
    );
  }
}
