import 'package:flower_app/core/localization/l10n/app_localizations.dart';
import 'package:flower_app/core/shared_widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../widgets/contact_address_card.dart';
import '../widgets/estimated_arrived_widget.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //ToDo: map will be here
          const SizedBox(height: 24),
          EstimatedArrivedWidget(estimatedTime: DateTime.now()),
          const SizedBox(height: 16),
          const Divider(color: AppColors.primaryColor, thickness: .5),
          const SizedBox(height: 40),
          ContactAddressCard(
            imageUrl: "",
            name: "driver data",
            onCallPressed: () {},
            onWhatsappPressed: () {},
          ),
          const SizedBox(height: 40),
          CustomButton(
            title: AppLocalizations.of(context)!.orderDetails,
            onPressed: () {},
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
