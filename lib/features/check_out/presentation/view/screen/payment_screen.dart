import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/enums/payment_method.dart';
import '../../../../../core/localization/l10n/app_localizations.dart';
import '../../../../cart/presentation/manager/cart_cubit.dart';
import '../../../../cart/presentation/manager/cart_state.dart';
import '../../../../cart/presentation/widget/custom_total_price.dart';
import '../../widgets/custom_checkout_button.dart';
import '../../widgets/custom_payment_method_selector.dart';

import '../../../../check_out/data/models/request/credit_payment_request.dart';

class PaymentStep extends StatefulWidget {
  const PaymentStep({
    super.key,
    required this.onNext,
    required this.onBack,
    required this.onPaymentMethodSelected,
    required this.buildPaymentRequest,
    required this.isGift,
  });

  final bool isGift;

  final VoidCallback onNext;
  final VoidCallback onBack;

  final ValueChanged<PaymentMethod> onPaymentMethodSelected;

  final CheckoutPaymentRequest Function() buildPaymentRequest;

  @override
  State<PaymentStep> createState() => _PaymentStepState();
}

class _PaymentStepState extends State<PaymentStep> {
  PaymentMethod? selectedMethod;

  List<PaymentMethod> get _methods {
    if (widget.isGift) {
      return [PaymentMethod.card]; // 👈 Gift = Card only
    }

    return [
      PaymentMethod.cash,
      PaymentMethod.card,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Column(
      children: [
        /// ================= PAYMENT METHODS =================
        PaymentMethodSelector(
          selectedMethod: selectedMethod,
          availableMethods: _methods,

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

        /// ================= TOTAL PRICE =================
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

        /// ================= NEXT BUTTON =================
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