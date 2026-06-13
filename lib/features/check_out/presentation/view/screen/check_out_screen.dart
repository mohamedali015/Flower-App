import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/enums/payment_method.dart';
import '../../../../../config/route_manager/routes.dart';
import '../../../../../config/user/manager/user_cubit.dart';
import '../../../../../core/localization/l10n/app_localizations.dart';
import '../../../../cart/presentation/manager/cart_cubit.dart';
import '../../../../cart/presentation/manager/cart_event.dart';
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

  // Checkout flow state
  bool isGift = false;
  String? addressType;
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

  void _placeOrder() {
    if (selectedPaymentMethod == PaymentMethod.cash) {
      context.read<CheckoutCubit>().doIntent(CashPaymentIntent());
    } else if (selectedPaymentMethod == PaymentMethod.card) {
      final userPhone = context.read<UserCubit>().state.user?.phone ?? "+201234567890";
      final streetStr = isGift
          ? "Gift to $giftName"
          : "${addressType ?? 'Home'} (2XVP+XC - Sheikh Zayed)";
      final phoneStr = isGift ? (giftPhone ?? userPhone) : userPhone;

      final request = CheckoutPaymentRequest(
        shippingAddress: ShippingAddress(
          street: streetStr,
          phone: phoneStr,
          city: "Cairo",
          lat: "30.0768",
          long: "31.0182",
        ),
      );
      context.read<CheckoutCubit>().doIntent(CreditPaymentIntent(request));
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    final titles = [local.address, local.payment, local.trackOrder];

    final pages = [
      AddressStep(
        onNext: nextStep,
        onAddressSelected: ({
          required bool isGift,
          required String? addressType,
          required String? giftName,
          required String? giftPhone,
        }) {
          setState(() {
            this.isGift = isGift;
            this.addressType = addressType;
            this.giftName = giftName;
            this.giftPhone = giftPhone;
          });
        },
      ),
      PaymentStep(
        onNext: nextStep,
        onBack: previousStep,
        onPaymentMethodSelected: (method) {
          setState(() {
            selectedPaymentMethod = method;
          });
        },
      ),
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
              Navigator.pushReplacementNamed(context, Routes.cartRoute);
            }
          },
        ),
      ),
      body: BlocConsumer<CheckoutCubit, CheckoutState>(
        listener: (context, state) async {
          // Cash Payment listeners
          if (state.cashPaymentState.isSuccess) {
            context.read<CartCubit>().doEvent(GetCartItemsEvent());
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                title: const Text('Order Placed'),
                content: const Text('Your cash order has been placed successfully!'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // pop dialog
                      Navigator.of(context).pushReplacementNamed(Routes.bottomNavBarRoute);
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          } else if (state.cashPaymentState.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.cashPaymentState.errorMessage!)),
            );
          }

          // Credit Payment listeners
          if (state.creditPaymentState.isSuccess) {
            final url = state.creditPaymentState.data?.session?.url;
            if (url != null) {
              final isSuccess = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentWebViewScreen(url: url),
                ),
              );
              if (!context.mounted) return;
              if (isSuccess == true) {
                context.read<CartCubit>().doEvent(GetCartItemsEvent());
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => AlertDialog(
                    title: const Text('Payment Successful'),
                    content: const Text('Your payment has been processed successfully!'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pushReplacementNamed(Routes.bottomNavBarRoute);
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Payment cancelled or failed.')),
                );
              }
            }
          } else if (state.creditPaymentState.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.creditPaymentState.errorMessage!)),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state.cashPaymentState.isLoading || state.creditPaymentState.isLoading;

          return Stack(
            children: [
              Column(
                children: [
                  CheckoutStepper(currentStep: currentStep),
                  Expanded(
                    child: IndexedStack(index: currentStep, children: pages),
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
