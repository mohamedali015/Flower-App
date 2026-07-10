import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/cart/manager/cart_cubit.dart';
import '../../../../../config/cart/manager/cart_state.dart';
import '../../../../../config/enums/payment_method.dart';
import '../../../../../config/route_manager/routes.dart';
import '../../../../../core/localization/l10n/app_localizations.dart';
import '../../../../../core/shared_widgets/custom_button.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../cart/presentation/widget/custom_total_price.dart';
import '../../../../user_address/domain/entities/address.dart';
import '../../../../user_address/presentation/manger/user_address_cubit.dart';
import '../../../../user_address/presentation/manger/user_address_state.dart';
import '../../../data/models/request/credit_payment_request.dart';
import '../../manager/checkout_cubit.dart';
import '../../manager/checkout_intents.dart';
import '../widgets/custom_checkout_button.dart';
import '../widgets/custom_delivery_address.dart';
import '../widgets/custom_delivery_time.dart';
import '../widgets/custom_divider.dart';
import '../widgets/custom_payment_method_selector.dart';
import '../widgets/custom_switch_fields.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({super.key});

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
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

  PaymentMethod? selectedMethod;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(local.checkout),
        leading: const Icon(Icons.arrow_back_ios_new),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///? Delivery Time
            const CustomDeliveryTime(),
            const CustomDivider(),

            ///? Text Delivery Address
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                local.deliveryAddress,
                style: AppTextStyles.medium18(
                  context,
                ).copyWith(fontWeight: FontWeight.bold),
              ),
            ),

            /// ADDRESS LIST
            IgnorePointer(
              ignoring: isEnabled,
              child: Opacity(
                opacity: isEnabled ? 0.5 : 1,
                child: BlocBuilder<UserAddressCubit, UserAddressState>(
                  builder: (context, state) {
                    final loading = state.getLoggedUserAddressState.isLoading;

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
                            titleStyle: AppTextStyles.medium16(context)
                                .copyWith(
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
            const CustomDivider(),

            ///? Switch gift
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomSwitchFields(
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
            ),
            const CustomDivider(),

            ///? Payment method
            PaymentMethodSelector(
              selectedMethod: selectedMethod,
              onChanged: (method) {
                setState(() {
                  selectedMethod = method;
                });
              },
              onCardSelected: () {
                setState(() {
                  selectedMethod = PaymentMethod.card;
                });
              },
            ),
            const CustomDivider(),

            ///? Total Cart Items
            BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                final cartData = state.getCartItemsState.data;
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 24,
                  ),
                  child: CustomTotalPrice(
                    subTotal: cartData?.totalPriceAfterDiscount ?? 0,
                    deliveryFee: 10,
                  ),
                );
              },
            ),

            BlocListener<CheckoutCubit, CheckoutState>(
              listener: (context, state) {
                if (state.cashPaymentState.isSuccess) {
                  Navigator.pushNamed(context, Routes.ordersRoute);
                }

                if (state.creditPaymentState.isSuccess) {
                  final response = state.creditPaymentState.data;

                  Navigator.pushNamed(
                    context,
                    Routes.paymentScreenRoute,
                    arguments: response?.session?.url,
                  );
                }

                if (state.cashPaymentState.errorMessage != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.cashPaymentState.errorMessage!),
                    ),
                  );
                }

                if (state.creditPaymentState.errorMessage != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.creditPaymentState.errorMessage!),
                    ),
                  );
                }
              },

              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),

                child: CustomCheckoutButton(
                  title: local.placeOrder,

                  validator: () {
                    return isFormValid;
                  },

                  errorMessage: local.pleaseCompleteYourData,

                  onNext: () {
                    final request = CheckoutPaymentRequest(
                      shippingAddress: ShippingAddress(
                        street: selectedAddress?.street,

                        phone: selectedAddress?.phone,

                        city: selectedAddress?.city,

                        lat: selectedAddress?.lat,

                        long: selectedAddress?.long,
                      ),
                    );

                    if (selectedMethod == PaymentMethod.cash) {
                      context.read<CheckoutCubit>().doIntent(
                        CashPaymentIntent(request),
                      );
                    } else if (selectedMethod == PaymentMethod.card) {
                      context.read<CheckoutCubit>().doIntent(
                        CreditPaymentIntent(request),
                      );
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
