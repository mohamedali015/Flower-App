// import 'package:flower_app/config/route_manager/routes.dart';
// import 'package:flower_app/core/utils/app_colors.dart';
// import 'package:flower_app/core/utils/app_text_styles.dart';
// import 'package:flower_app/features/check_out/presentation/widgets/custom_delivery_time.dart';
// import 'package:flutter/material.dart';
// import '../../../../config/enums/payment_method.dart';
// import '../../../../core/localization/l10n/app_localizations.dart';
// import '../../../../core/shared_widgets/custom_button.dart';
// import '../widgets/custom_delivery_address.dart';
// import '../widgets/custom_divider.dart';
// import '../widgets/custom_payment_method_selector.dart';
// import '../widgets/custom_switch_fields.dart';
//
// class CheckOutScreen extends StatefulWidget {
//   const CheckOutScreen({super.key});
//
//   @override
//   State<CheckOutScreen> createState() => _CheckOutScreenState();
// }
//
// class _CheckOutScreenState extends State<CheckOutScreen> {
//   bool isEnabled = false;
//
//   PaymentMethod? selectedMethod;
//
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final FocusNode phoneFocus = FocusNode();
//
//   @override
//   void dispose() {
//     nameController.dispose();
//     phoneController.dispose();
//     phoneFocus.dispose();
//     super.dispose();
//   }
//
//   String getPaymentType(PaymentMethod method) {
//     switch (method) {
//       case PaymentMethod.cash:
//         return "cash_on_delivery";
//       case PaymentMethod.card:
//         return "credit_card";
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final local = AppLocalizations.of(context)!;
//
//     return Scaffold(
//       ///? AppBar
//       appBar: AppBar(
//         title: Text(local.checkout),
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pushReplacementNamed(context, Routes.cartRoute);
//           },
//           icon: const Icon(Icons.arrow_back_ios_new),
//         ),
//       ),
//
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//
//             const CustomDeliveryTime(),
//
//             const CustomDivider(),
//
//             const SizedBox(height: 24),
//
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Text(
//                 local.deliveryAddress,
//                 style: AppTextStyles.medium18(
//                   context,
//                 ).copyWith(fontWeight: FontWeight.bold),
//               ),
//             ),
//             const SizedBox(height: 8,),
//             const CustomDeliveryAddress(
//               title: "Home",
//               onTapEdit: AboutDialog.adaptive,
//               subTitle: "2XVP+XC - Sheikh Zayed",
//             ),
//             const CustomDeliveryAddress(
//               title: "office",
//               onTapEdit: AboutDialog.adaptive,
//               subTitle: "2XVP+XC - Sheikh Zayed",
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 24),
//               child: CustomButton(
//                 title: local.addNew,
//                 backgroundColor: AppColors.background,
//                 borderColor: AppColors.hintTextGray,
//                 titleStyle: AppTextStyles.medium16(context).copyWith(
//                   color: AppColors.primaryColor,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 onPressed: () {},
//               ),
//             ),
//
//             const CustomDivider(),
//
//             ///? Payment
//             PaymentMethodSelector(
//               selectedMethod: selectedMethod,
//               onChanged: (method) {
//                 setState(() {
//                   selectedMethod = method;
//                 });
//               },
//             ),
//             const CustomDivider(),
//
//             ///?  Gift Section
//             CustomSwitchFields(
//               value: isEnabled,
//               onChanged: (value) {
//                 setState(() {
//                   isEnabled = value;
//                 });
//               },
//               nameController: nameController,
//               phoneController: phoneController,
//               phoneFocus: phoneFocus,
//               isLoading: false,
//             ),
//
//
//
//             ///?  Place Order Button
//             Padding(
//               padding: const EdgeInsetsGeometry.symmetric(horizontal: 16),
//               child: CustomButton(
//                 title: local.placeOrder,
//                 onPressed: () {
//                   if (selectedMethod == null) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                         content: Text("Please select payment method"),
//                       ),
//                     );
//                     return;
//                   }
//
//                   // TODO: API CALL
//                 },
//               ),
//             ),
//             const SizedBox(height: 25,),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../../../../config/route_manager/routes.dart';
import '../../../../core/localization/l10n/app_localizations.dart';
import '../widgets/checkout_stepper.dart';
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

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    final titles = [
      local.address,
      local.payment,
      local.trackOrder,
    ];

    final pages = [
      AddressStep(onNext: nextStep),
      PaymentStep(onNext: nextStep, onBack: previousStep),
      TrackOrderStep(onBack: previousStep),
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