import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/route_manager/routes.dart';
import '../../../../../core/localization/l10n/app_localizations.dart';
import '../../../../../core/shared_widgets/custom_button.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../user_address/domain/entities/address.dart';
import '../../../../user_address/presentation/manger/user_address_cubit.dart';
import '../../../../user_address/presentation/manger/user_address_state.dart';
import '../widgets/custom_checkout_button.dart';
import '../widgets/custom_delivery_address.dart';
import '../widgets/custom_switch_fields.dart';

class AddressStep extends StatefulWidget {
  const AddressStep({
    super.key,
    required this.onNext,
    required this.onAddressSelected,
  });

  final VoidCallback onNext;

  final void Function({
    required bool isGift,
    required Address? address,
    required String? giftName,
    required String? giftPhone,
  })
  onAddressSelected;

  @override
  State<AddressStep> createState() => _AddressStepState();
}

class _AddressStepState extends State<AddressStep> {
  bool isEnabled = false;

  Address? selectedAddress;

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

  void selectAddress(Address address) {
    setState(() {
      selectedAddress = address;
    });
  }

  bool get isFormValid {
    if (isEnabled) {
      return nameController.text.isNotEmpty && phoneController.text.isNotEmpty;
    }

    return selectedAddress != null;
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      child: Column(
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
              style: AppTextStyles.medium18(
                context,
              ).copyWith(fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 8),

          /// ADDRESS LIST
          IgnorePointer(
            ignoring: isEnabled,
            child: Opacity(
              opacity: isEnabled ? 0.5 : 1,
              child: BlocBuilder<UserAddressCubit, UserAddressState>(
                builder: (context, state) {
                  final loading = state.getLoggedUserAddressesState.isLoading;

                  final addresses = state.currentUserAddresses ?? <Address>[];

                  if (loading) {
                    return const Padding(
                      padding: EdgeInsets.all(24),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (addresses.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          const Text('No Address Found'),
                          const SizedBox(height: 24),
                          CustomButton(
                            title: local.addNew,
                            backgroundColor: AppColors.background,
                            borderColor: AppColors.hintTextGray,
                            titleStyle: AppTextStyles.medium16(context)
                                .copyWith(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                Routes.savedAddressesRoute,
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  }

                  return Column(
                    children: [
                      ...addresses.map(
                        (address) => GestureDetector(
                          onTap: () => selectAddress(address),
                          child: CustomDeliveryAddress(
                            address: address,
                            isSelected: selectedAddress?.id == address.id,
                            onTapEdit: () {
                              Navigator.pushNamed(
                                context,
                                Routes.addAddressRoute,
                                arguments: address,
                              );
                            },
                          ),
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
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              Routes.addAddressRoute,
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 24),

          /// NEXT BUTTON
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
            child: CustomCheckoutButton(
              title: local.next,
              errorMessage: isEnabled
                  ? local.invalidData
                  : local.pleaseSelectAddress,
              validator: () => isFormValid,
              onNext: () {
                if (!isFormValid) return;

                widget.onAddressSelected(
                  isGift: isEnabled,
                  address: selectedAddress,
                  giftName: isEnabled ? nameController.text.trim() : null,
                  giftPhone: isEnabled ? phoneController.text.trim() : null,
                );

                widget.onNext();
              },
            ),
          ),
        ],
      ),
    );
  }
}
