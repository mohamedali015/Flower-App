import 'package:flower_app/config/route_manager/routes.dart';
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
import '../../../../core/helpers/event_handler_mixin.dart';
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

class _TrackOrderScreenState extends State<TrackOrderScreen>
    with EventHandlerMixin {
  late AppLocalizations localizations;
  late TrackOrderCubit _trackOrderCubit;

  @override
  void initState() {
    _trackOrderCubit = context.read<TrackOrderCubit>();

    _trackOrderCubit.eventStream.listen((event) {
      if (!mounted) return;

      handleEvent(event);
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    localizations = AppLocalizations.of(context)!;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(localizations.trackOrder)),
      body: BlocBuilder<TrackOrderCubit, TrackOrderState>(
        builder: (context, state) {
          final trackState = state.trackOrderState;

          if (trackState.isLoading) {
            return const CustomLoadingIndicator();
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
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              Routes.mapScreenRoute,
                              arguments: order.id,
                            );
                          },
                        ),
                      ),
                      if (orderStatus == OrderStatus.delivered) ...[
                        const SizedBox(width: 12),
                        Expanded(
                          child: CustomButton(
                            title: localizations.orderDelivered,
                            isLoading: state.updateOrderState.isLoading,
                            onPressed: () {
                              _trackOrderCubit.doEvent(
                                UpdateOrderToCompletedEvent(
                                  orderId: widget.orderId,
                                ),
                              );
                            },
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
    );
  }
}
