import 'package:flutter/material.dart';

import '../../../../core/localization/l10n/app_localizations.dart';
import '../../../../core/shared_widgets/custom_button.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../widgets/custom_checkout_button.dart';
import '../widgets/custom_delivery_address.dart';
import '../widgets/custom_switch_fields.dart';

class AddressStep extends StatefulWidget {
  const AddressStep({super.key, required this.onNext});

  final VoidCallback onNext;

  @override
  State<AddressStep> createState() => _AddressStepState();
}

class _AddressStepState extends State<AddressStep> {
  bool isEnabled = false;

  String? selectedAddress;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final FocusNode phoneFocus = FocusNode();

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    phoneFocus.dispose();
    super.dispose();
  }

  void selectAddress(String address) {
    setState(() {
      selectedAddress = address;
    });
  }

  bool get isFormValid {
    if (isEnabled) {
      return nameController.text.isNotEmpty &&
          phoneController.text.isNotEmpty;
    }
    return selectedAddress != null;
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// SWITCH
        CustomSwitchFields(
          value: isEnabled,
          onChanged: (value) {
            setState(() {
              isEnabled = value;
              selectedAddress = null;
            });
          },
          nameController: nameController,
          phoneController: phoneController,
          phoneFocus: phoneFocus,
          isLoading: false,
        ),

        /// TITLE
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            local.deliveryAddress,
            style: AppTextStyles.medium18(context).copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(height: 8),

        /// ADDRESS LIST
        IgnorePointer(
          ignoring: isEnabled,
          child: Opacity(
            opacity: isEnabled ? 0.5 : 1,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => selectAddress('Home'),
                  child: CustomDeliveryAddress(
                    title: 'Home',
                    subTitle: '2XVP+XC - Sheikh Zayed',
                    onTapEdit: () {},
                    isSelected: selectedAddress == 'Home',
                  ),
                ),

                GestureDetector(
                  onTap: () => selectAddress('Office'),
                  child: CustomDeliveryAddress(
                    title: 'Office',
                    subTitle: '2XVP+XC - Sheikh Zayed',
                    onTapEdit: () {},
                    isSelected: selectedAddress == 'Office',
                  ),
                ),





                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 24,
                  ),
                  child: CustomButton(
                    title: local.addNew,
                    backgroundColor: AppColors.background,
                    borderColor: AppColors.hintTextGray,
                    titleStyle: AppTextStyles.medium16(context).copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),

        const Spacer(),

        ///? next button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
          child: CustomCheckoutButton(
            title: local.next,
            errorMessage: isEnabled
                ? local.invalidData
                : local.pleaseSelectAddress,
            validator: () => isFormValid,
            onNext: widget.onNext,
          ),
        ),
      ],
    );
  }
}