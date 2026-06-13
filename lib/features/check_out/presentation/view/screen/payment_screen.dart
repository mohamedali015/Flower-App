import 'package:flower_app/config/enums/payment_method.dart';
import 'package:flower_app/features/check_out/presentation/view/widgets/custom_payment_method_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/localization/l10n/app_localizations.dart';
import '../../../../cart/presentation/manager/cart_cubit.dart';
import '../../../../cart/presentation/manager/cart_state.dart';
import '../../../../cart/presentation/widget/custom_total_price.dart';
import '../widgets/custom_checkout_button.dart';

class PaymentStep extends StatefulWidget {
  const PaymentStep({
    super.key,
    required this.onNext,
    required this.onBack,
    required this.onPaymentMethodSelected,
  });

  final VoidCallback onNext;
  final VoidCallback onBack;
  final ValueChanged<PaymentMethod> onPaymentMethodSelected;

  @override
  State<PaymentStep> createState() => _PaymentStepState();
}

class _PaymentStepState extends State<PaymentStep> {
  PaymentMethod? selectedMethod;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Column(
      children: [
        PaymentMethodSelector(
          selectedMethod: selectedMethod,
          onChanged: (method) {
            setState(() {
              selectedMethod = method;
            });
          },
        ),

        BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            final cartData = state.getCartItemsState.data;

            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 24,
              ),
              child: CustomTotalPrice(
                subTotal: cartData?.totalPriceAfterDiscount ?? 0,
                deliveryFee: 10,
              ),
            );
          },
        ),

        Padding(
          padding: const EdgeInsets.all(16),
          child: CustomCheckoutButton(
            title: local.trackOrder,
            errorMessage: local.pleaseSelectPayment,
            validator: () => selectedMethod != null,
            onNext: () {
              widget.onPaymentMethodSelected(selectedMethod!);
              widget.onNext();
            },
          ),
        ),
      ],
    );
  }
}
