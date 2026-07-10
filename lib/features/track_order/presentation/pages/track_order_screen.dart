import 'package:flower_app/core/localization/l10n/app_localizations.dart';
import 'package:flower_app/core/shared_widgets/custom_button.dart';
import 'package:flower_app/core/shared_widgets/custom_loading_indicator.dart';
import 'package:flower_app/core/shared_widgets/svg_wrapper.dart';
import 'package:flower_app/core/utils/app_assets.dart';
import 'package:flower_app/core/utils/app_colors.dart';
import 'package:flower_app/core/utils/app_text_styles.dart';
import 'package:flower_app/features/track_order/domain/enums/order_status_enum.dart';
import 'package:flower_app/features/track_order/presentation/manager/track_order_cubit.dart';
import 'package:flower_app/features/track_order/presentation/manager/track_order_events.dart';
import 'package:flower_app/features/track_order/presentation/manager/track_order_state.dart';
import 'package:flower_app/features/track_order/presentation/widgets/contact_address_card.dart';
import 'package:flower_app/features/track_order/presentation/widgets/estimated_arrived_widget.dart';
import 'package:flower_app/features/track_order/presentation/widgets/order_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/di/di.dart';
import '../../../../core/helpers/url_launcher_helper.dart';
import '../../../../core/utils/app_constants.dart';
import '../widgets/order_items_widget.dart';
import '../widgets/track_order_info_card.dart';

class TrackOrderScreen extends StatefulWidget {
  final String orderId;

  const TrackOrderScreen({super.key, required this.orderId});

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
    return BlocProvider(
      create: (context) =>
          getIt<TrackOrderCubit>()
            ..doEvent(GetTrackOrderEvent(orderId: widget.orderId)),
      child: Scaffold(
        appBar: AppBar(title: Text(localizations.trackOrder)),
        body: BlocBuilder<TrackOrderCubit, TrackOrderState>(
          builder: (context, state) {
            final trackState = state.trackOrderState;

            if (trackState.isLoading) {
              return const Center(child: CustomLoadingIndicator());
            }

            if (trackState.data == null || trackState.data!.id.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.hourglass_empty,
                      size: 80,
                      color: AppColors.primaryColor,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      localizations.orderIsPending,
                      style: AppTextStyles.medium18(context),
                    ),
                  ],
                ),
              );
            }

            final order = trackState.data!;
            final orderStatus = OrderStatus.fromString(order.orderStatus);

            return Padding(
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
                          EstimatedArrivedWidget(
                            estimatedTime:
                                DateTime.tryParse(order.updatedAt) ??
                                DateTime.now(),
                          ),
                          const SizedBox(height: 16),
                          const Divider(
                            color: AppColors.primaryColor,
                            thickness: .5,
                          ),
                          const SizedBox(height: 40),
                          ContactAddressCard(
                            imageUrl: order.store.image,
                            name: order.store.name.isEmpty
                                ? "Store"
                                : order.store.name,
                            onCallPressed: () {
                              if (order.store.phoneNumber.isNotEmpty) {
                                getIt<UrlLauncherHelper>().callPhone(
                                  order.store.phoneNumber,
                                );
                              }
                            },
                            onWhatsappPressed: () {
                              if (order.store.phoneNumber.isNotEmpty) {
                                getIt<UrlLauncherHelper>().launchWhatsApp(
                                  order.store.phoneNumber,
                                );
                              }
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
                          OrderTimeline(currentStatus: orderStatus),
                          const SizedBox(height: 20),
                          OrderItemsWidget(
                            products: order.orderItems
                                .map((e) => e.product)
                                .toList(),
                          ),
                          const SizedBox(height: 20),
                          TrackOrderInfoCard(
                            iconPath: AppAssets.moneyIcon,
                            title: '${localizations.egp} ${order.totalPrice}',
                            subTitle: order.paymentType.toLowerCase() == "cash"
                                ? localizations.cashOnDelivery
                                : localizations.creditCard,
                          ),
                          const SizedBox(height: 24),
                          TrackOrderInfoCard(
                            iconPath: AppAssets.location,
                            title: localizations.home,
                            subTitle: order.shippingAddress.street,
                          ),
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
                        if (orderStatus == OrderStatus.delivered) ...[
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
            );
          },
        ),
      ),
    );
  }
}
