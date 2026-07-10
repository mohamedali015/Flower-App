import 'package:flower_app/features/track_order/domain/enums/order_status_enum.dart';
import 'package:flutter/material.dart';

import '../../../../core/localization/l10n/app_localizations.dart';
import '../../../../core/shared_widgets/timeline_tile_wrapper.dart';

class OrderTimeline extends StatelessWidget {
  final OrderStatus currentStatus;

  const OrderTimeline({super.key, required this.currentStatus});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TimelineTileWrapper(
            isFirst: true,
            status: OrderStatus.accepted,
            currentStatus: currentStatus,
            label: local.receivedYourOrder,
            nextStatus: OrderStatus.picked,
          ),
          TimelineTileWrapper(
            status: OrderStatus.picked,
            currentStatus: currentStatus,
            label: local.preparingYourOrder,
            nextStatus: OrderStatus.outForDelivery,
          ),
          TimelineTileWrapper(
            status: OrderStatus.outForDelivery,
            currentStatus: currentStatus,
            label: local.outForDelivery,
            nextStatus: OrderStatus.arrived,
          ),
          TimelineTileWrapper(
            status: OrderStatus.arrived,
            currentStatus: currentStatus,
            label: local.deliveryArrived,
            nextStatus: OrderStatus.delivered,
          ),
          TimelineTileWrapper(
            isLast: true,
            status: OrderStatus.delivered,
            currentStatus: currentStatus,
            label: local.delivered,
          ),
        ],
      ),
    );
  }
}
