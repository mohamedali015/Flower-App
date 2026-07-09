import 'package:flower_app/core/localization/l10n/app_localizations.dart';
import 'package:flower_app/core/shared_widgets/custom_button.dart';
import 'package:flower_app/core/shared_widgets/svg_wrapper.dart';
import 'package:flower_app/core/utils/app_assets.dart';
import 'package:flower_app/core/utils/app_colors.dart';
import 'package:flower_app/features/track_order/domain/enums/order_status_enum.dart';
import 'package:flower_app/features/track_order/presentation/widgets/contact_address_card.dart';
import 'package:flower_app/features/track_order/presentation/widgets/estimated_arrived_widget.dart';
import 'package:flower_app/features/track_order/presentation/widgets/order_timeline.dart';
import 'package:flutter/material.dart';

import '../../../../config/di/di.dart';
import '../../../../core/helpers/url_launcher_helper.dart';
import '../../../../core/utils/app_constants.dart';

class TrackOrderScreen extends StatefulWidget {
  const TrackOrderScreen({super.key});

  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  late AppLocalizations localizations;

  @override
  void didChangeDependencies() {
    localizations = AppLocalizations.of(context)!;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    const OrderStatus orderState = OrderStatus.arrived;
    return Scaffold(
      appBar: AppBar(title: Text(localizations.trackOrder)),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingHorizontal,
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    EstimatedArrivedWidget(estimatedTime: DateTime.now()),
                    const SizedBox(height: 16),
                    const Divider(color: AppColors.primaryColor, thickness: .5),
                    const SizedBox(height: 40),
                    ContactAddressCard(
                      imageUrl: '',
                      name: "Mohamed Ali",
                      onCallPressed: () {
                        getIt<UrlLauncherHelper>().callPhone("+201020374526");
                      },
                      onWhatsappPressed: () {
                        getIt<UrlLauncherHelper>().launchWhatsApp(
                          "+201020374526",
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    const Center(
                      child: SvgWrapper(
                        path: AppAssets.carIcon,
                        width: 213,
                        height: 83,
                        fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(height: 40),
                    const OrderTimeline(currentStatus: orderState),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      title: localizations.showMap,
                      onPressed: () {},
                    ),
                  ),
                  if (orderState == OrderStatus.delivered) ...[
                    const SizedBox(width: 12),
                    Expanded(
                      child: CustomButton(
                        title: localizations.orderDelivered,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
