import 'package:flower_app/core/helpers/my_responsive.dart';
import 'package:flower_app/core/localization/l10n/app_localizations.dart';
import 'package:flower_app/core/shared_widgets/shimmer/bottom_pagination_shimmer.dart';
import 'package:flower_app/features/orders/domain/entities/orders_entity.dart';
import 'package:flower_app/features/orders/presentation/manager/orders_cubit.dart';
import 'package:flower_app/features/orders/presentation/manager/orders_events.dart';
import 'package:flower_app/features/orders/presentation/widgets/order_card.dart';
import 'package:flutter/material.dart';

class OrdersList extends StatelessWidget {
  const OrdersList({
    super.key,
    required this.context,
    required this.local,
    required this.orders,
    required this.cubit,
    required this.isFetchingMore,
  });

  final BuildContext context;
  final List<OrdersEntity> orders;
  final AppLocalizations local;
  final OrdersCubit cubit;
  final bool isFetchingMore;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification is ScrollEndNotification) {
          final pixel = notification.metrics.pixels;
          final max = notification.metrics.maxScrollExtent;
          const triggerDistance = 200;

          if (pixel >= max - triggerDistance) {
            if (!isFetchingMore) {
              cubit.doEvent(LoadMoreOrdersEvent());
            }
          }
        }
        return false;
      },
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: MyResponsive.paddingSymmetric(
                context,
                horizontal: 16.0,
                vertical: 20.0,
              ),
              itemCount: orders.length,
              separatorBuilder: (_, _) =>
                  SizedBox(height: MyResponsive.height(context, value: 18)),
              itemBuilder: (context, index) {
                return OrderCard(order: orders[index], local: local);
              },
            ),
          ),
          if (isFetchingMore)
            const Padding(
              padding: EdgeInsets.only(bottom: 16.0, top: 8.0),
              child: BottomPaginationShimmer(),
            ),
        ],
      ),
    );
  }
}
