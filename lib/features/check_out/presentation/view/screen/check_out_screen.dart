import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/enums/payment_method.dart';
import '../../../../../config/user/manager/user_cubit.dart';
import '../../../../../core/localization/l10n/app_localizations.dart';
import '../../../../cart/presentation/manager/cart_cubit.dart';
import '../../../../cart/presentation/manager/cart_event.dart';
import '../../../../user_address/domain/entities/address.dart';
import '../../../data/models/request/credit_payment_request.dart';
import '../../manager/checkout_cubit.dart';
import '../../manager/checkout_intents.dart';
import '../widgets/checkout_stepper.dart';
import 'address_screen.dart';
import 'payment_screen.dart';
import 'payment_webview_screen.dart';
import 'track_order_screen.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  int currentStep = 0;

  bool isGift = false;
  Address? selectedAddress;
  String? giftName;
  String? giftPhone;

  PaymentMethod? selectedPaymentMethod;

  void nextStep() {
    if (currentStep < 2) {
      setState(() => currentStep++);
    }
  }

  void previousStep() {
    if (currentStep > 0) {
      setState(() => currentStep--);
    }
  }

  ShippingAddress _buildShippingAddress() {
    final userPhone =
        context.read<UserCubit>().state.user?.phone ?? "+201234567890";

    if (isGift) {
      return ShippingAddress(
        street: "Gift to $giftName",
        phone: giftPhone ?? userPhone,
        city: selectedAddress?.city ?? "Cairo",
        lat: selectedAddress?.lat ?? "30.0768",
        long: selectedAddress?.long ?? "31.0182",
      );
    }

    return ShippingAddress(
      street: selectedAddress?.street ?? "",
      phone: selectedAddress?.phone ?? userPhone,
      city: selectedAddress?.city ?? "Cairo",
      lat: selectedAddress?.lat ?? "30.0768",
      long: selectedAddress?.long ?? "31.0182",
    );
  }


  void _placeOrder() {
    final cubit = context.read<CheckoutCubit>();
    final address = _buildShippingAddress();

    if (selectedPaymentMethod == PaymentMethod.cash) {
      cubit.doIntent(CashPaymentIntent());
      return;
    }

    if (selectedPaymentMethod == PaymentMethod.card) {
      final request = CheckoutPaymentRequest(
        shippingAddress: address,
      );

      cubit.doIntent(CreditPaymentIntent(request));
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    final titles = [
      local.address,
      local.payment,
      local.trackOrder,
    ];

    final pages = [
      /// ================= ADDRESS =================
      AddressStep(
        onNext: nextStep,
        onAddressSelected: ({
          required bool isGift,
          required Address? address,
          required String? giftName,
          required String? giftPhone,
        }) {
          setState(() {
            this.isGift = isGift;
            this.selectedAddress = address;
            this.giftName = giftName;
            this.giftPhone = giftPhone;
          });
        },
      ),

      /// ================= PAYMENT =================
      PaymentStep(
        onNext: nextStep,
        onBack: previousStep,
        onPaymentMethodSelected: (method) {
          setState(() {
            selectedPaymentMethod = method;
          });
        },
        buildPaymentRequest: () {
          return CheckoutPaymentRequest(
            shippingAddress: _buildShippingAddress(),
          );
        },
      ),

      /// ================= TRACK ORDER =================
      TrackOrderStep(
        onBack: previousStep,
        onPlaceOrder: _placeOrder,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(titles[currentStep]),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            if (currentStep > 0) {
              previousStep();
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),

      body: BlocConsumer<CheckoutCubit, CheckoutState>(
        listener: (context, state) async {
          if (state.cashPaymentState.isSuccess) {
            context.read<CartCubit>().doEvent(GetCartItemsEvent());
          }

          if (state.creditPaymentState.isSuccess) {
            final url = state.creditPaymentState.data?.session?.url;

            if (url != null) {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PaymentWebViewScreen(url: url),
                ),
              );

              if (!context.mounted) return;

              if (result == true) {
                context.read<CartCubit>().doEvent(GetCartItemsEvent());
              }
            }
          }
        },

        builder: (context, state) {
          final isLoading =
              state.cashPaymentState.isLoading ||
                  state.creditPaymentState.isLoading;

          return Stack(
            children: [
              Column(
                children: [
                  CheckoutStepper(currentStep: currentStep),
                  Expanded(
                    child: IndexedStack(
                      index: currentStep,
                      children: pages,
                    ),
                  ),
                ],
              ),

              if (isLoading)
                Container(
                  color: Colors.black45,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}