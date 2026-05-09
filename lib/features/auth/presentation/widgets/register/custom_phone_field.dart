import 'package:flutter/material.dart';
import 'package:flutter_intl_phone_field/country_picker_dialog.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';

import '../../../../../core/helpers/my_responsive.dart';
import '../../../../../core/localization/l10n/app_localizations.dart';
import '../../../../../core/values/app_strings.dart';

class CustomPhoneField extends StatelessWidget {
  const CustomPhoneField({
    super.key,
    required this.phoneController,
    required this.isLoading,
    required this.phoneFocus,
  });

  final TextEditingController phoneController;
  final FocusNode phoneFocus;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return IntlPhoneField(
      initialCountryCode: 'EG',
      dialogType: DialogType.showModalBottomSheet,
      enabled: !isLoading,
      autovalidateMode: AutovalidateMode.disabled,
      focusNode: phoneFocus,

      textInputAction: TextInputAction.done,

      onSubmitted: (_) {
        FocusScope.of(context).unfocus();
      },
      pickerDialogStyle: PickerDialogStyle(
        padding: MyResponsive.paddingSymmetric(
          horizontal: 20,
          vertical: 20,
          context,
        ),
      ),
      decoration: InputDecoration(
        labelText: local.phoneNumber,
        hintText: local.enterPhoneNumber,
      ),

      onChanged: (phone) {
        phoneController.text = phone.completeNumber;
      },

      invalidMessage: AppStrings.phoneInvalid,
    );
  }
}
