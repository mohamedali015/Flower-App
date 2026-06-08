import 'package:flutter/material.dart';
import '../../../../../core/helpers/validator.dart';
import '../../../../../core/localization/l10n/app_localizations.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../auth/presentation/widgets/register/custom_phone_field.dart';

class CustomSwitchFields extends StatelessWidget {
  const CustomSwitchFields({
    super.key,
    required this.value,
    required this.onChanged,
    required this.nameController,
    required this.phoneController,
    required this.phoneFocus,
    required this.isLoading,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final FocusNode phoneFocus;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Switch(
                  value: value,
                  onChanged: onChanged,
                  activeThumbColor: AppColors.primaryColor,
                  inactiveThumbColor: AppColors.grayDark,
                  inactiveTrackColor: AppColors.grayLight,
                ),
                const SizedBox(width: 8),
                Text(
                  local.itIsAGift,
                  style: AppTextStyles.medium18(
                    context,
                  ).copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const SizedBox(height: 16),

            if (value) ...[
              const SizedBox(height: 16),

              TextFormField(
                controller: nameController,
                validator: Validator.name,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: local.name,
                  hintText: local.enterName,
                ),
              ),

              const SizedBox(height: 12),

              CustomPhoneField(
                phoneController: phoneController,
                phoneFocus: phoneFocus,
                isLoading: isLoading,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
