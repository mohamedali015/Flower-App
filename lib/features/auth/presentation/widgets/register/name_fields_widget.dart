import 'package:flower_app/core/helpers/my_responsive.dart';
import 'package:flutter/material.dart';

import '../../../../../core/helpers/validator.dart';
import '../../../../../core/localization/l10n/app_localizations.dart';

class NameFieldsWidget extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final bool isLoading;
  final AutovalidateMode validationMode;

  const NameFieldsWidget({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.isLoading,
    required this.validationMode,
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
            autovalidateMode: validationMode,
            keyboardType: TextInputType.name,
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
            autovalidateMode: validationMode,
            keyboardType: TextInputType.name,
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
