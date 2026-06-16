import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/enums/payment_method.dart';
import '../../../../../config/user/manager/user_cubit.dart';
import '../../../../../core/localization/l10n/app_localizations.dart';
import '../../../../user_address/domain/entities/address.dart';
import '../../../data/models/request/credit_payment_request.dart';
import '../../manager/checkout_cubit.dart';
import '../../manager/checkout_intents.dart';
import '../../widgets/checkout_stepper.dart';
import 'address_screen.dart';
import 'payment_screen.dart';
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

  void _resetPayment() {
    selectedPaymentMethod = null;
  }

  ShippingAddress _buildShippingAddress() {
    final userPhone = context.read<UserCubit>().state.user?.phone ?? "";

    if (isGift) {
      return ShippingAddress(
        street: "Gift To $giftName",
        phone: giftPhone ?? userPhone,
        city: "N/A",
        lat: "",
        long: "",
      );
    }

    final address = selectedAddress!;

    return ShippingAddress(
      street: address.street,
      phone: address.phone,
      city: address.city,
      lat: address.lat,
      long: address.long,
    );
  }

  void _placeOrder() {
    final cubit = context.read<CheckoutCubit>();
    final request = CheckoutPaymentRequest(
      shippingAddress: _buildShippingAddress(),
    );

    switch (selectedPaymentMethod) {
      case PaymentMethod.cash:
        ///? delete cart items and Order Screen
        cubit.doIntent(CashPaymentIntent(request));
        break;

      case PaymentMethod.card:
        ///? paymentScreen
        cubit.doIntent(
          CreditPaymentIntent(
            url: "http://flowerApp",
            request: request,
          ),
        );
        break;

      case null:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    final pages = [
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
            selectedAddress = address;
            this.giftName = giftName;
            this.giftPhone = giftPhone;

            _resetPayment();
          });
        },
      ),

      PaymentStep(
        isGift: isGift,
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

      TrackOrderStep(
        onBack: previousStep,
        onPlaceOrder: _placeOrder,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text([
          local.address,
          local.payment,
          local.trackOrder,
        ][currentStep]),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            currentStep == 0
                ? Navigator.pop(context) : previousStep();
          },
        ),
      ),
      body: Column(
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
    );
  }
}