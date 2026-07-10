import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/di/di.dart';
import '../../../../core/helpers/url_launcher_helper.dart';
import '../../../../core/localization/l10n/app_localizations.dart';
import '../../../../core/shared_widgets/custom_button.dart';
import '../../../../core/utils/app_colors.dart';
import '../manager/track_order_cubit.dart';
import '../manager/track_order_events.dart';
import '../manager/track_order_state.dart';
import '../widgets/contact_address_card.dart';
import '../widgets/estimated_arrived_widget.dart';
import '../widgets/live_map_widget.dart';

class MapScreen extends StatefulWidget {
  final String orderId;

  const MapScreen({super.key, required this.orderId});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (context) =>
          getIt<TrackOrderCubit>()
            ..doEvent(GetTrackOrderEvent(orderId: widget.orderId)),
      child: Scaffold(
        body: BlocBuilder<TrackOrderCubit, TrackOrderState>(
          builder: (context, state) {
            final order = state.trackOrderState.data;
            if (order == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              children: [
                Expanded(child: LiveMapWidget(order: order)),
                const SizedBox(height: 24),
                EstimatedArrivedWidget(
                  estimatedTime:
                      DateTime.tryParse(order.updatedAt) ?? DateTime.now(),
                ),
                const SizedBox(height: 16),
                const Divider(color: AppColors.primaryColor, thickness: .5),
                const SizedBox(height: 20),
                if (state.driverState.data != null)
                  ContactAddressCard(
                    name: state.driverState.data!.fullName,
                    onCallPressed: () {
                      if (state.driverState.data!.phone.isNotEmpty) {
                        getIt<UrlLauncherHelper>().callPhone(
                          state.driverState.data!.phone,
                        );
                      }
                    },
                    onWhatsappPressed: () {
                      if (state.driverState.data!.phone.isNotEmpty) {
                        getIt<UrlLauncherHelper>().launchWhatsApp(
                          state.driverState.data!.phone,
                        );
                      }
                    },
                  ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomButton(
                    title: local.orderDetails,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            );
          },
        ),
      ),
    );
  }
}
