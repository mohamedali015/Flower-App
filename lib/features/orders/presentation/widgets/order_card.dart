// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flower_app/core/helpers/my_responsive.dart';
import 'package:flower_app/core/localization/l10n/app_localizations.dart';
import 'package:flower_app/core/shared_widgets/cached_network_image_wrapper.dart';
import 'package:flower_app/core/utils/app_colors.dart';
import 'package:flower_app/core/utils/app_text_styles.dart';
import 'package:flower_app/features/orders/domain/entities/orders_entity.dart';

// ignore: must_be_immutable
class OrderCard extends StatelessWidget {
  final OrdersEntity order;
  late AppLocalizations local;

  OrderCard({super.key, required this.order, required this.local});

  String get title {
    final firstItem = order.orderItems?.first;
    return firstItem?.product?.title ?? local.order;
  }

  String get orderNumber => order.orderNumber ?? '—';

  String get totalPrice => order.totalPrice != null
      ? '${local.egp} ${order.totalPrice!.toStringAsFixed(2)}'
      : '${local.egp} 0';

  String get status {
    if (order.isDelivered == true) {
      return local.reorder;
    }

    return local.trackOrder;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: MyResponsive.paddingAll(context, value: 8).copyWith(right: 16),
      height: MyResponsive.height(context, value: 125),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(
          MyResponsive.radius(context, value: 8),
        ),
        border: Border.all(
          color: AppColors.grayDark,
          width: MyResponsive.width(context, value: 0.5),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: MyResponsive.width(context, value: 127),
            padding: MyResponsive.paddingAll(context, value: 8),
            child: Center(
              child: CachedNetworkImageWrapper(
                imagePath:
                    order.orderItems?.first.product?.imgCover.toString() ?? '',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(width: MyResponsive.width(context, value: 16)),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.regular12(
                        context,
                      ).copyWith(color: AppColors.darkBase),
                    ),
                    SizedBox(height: MyResponsive.height(context, value: 4)),
                    Text(totalPrice, style: AppTextStyles.medium14(context)),
                    SizedBox(height: MyResponsive.height(context, value: 4)),
                    Text(
                      '${local.orderNumber} $orderNumber',
                      style: AppTextStyles.regular12(
                        context,
                      ).copyWith(color: AppColors.grayDark),
                    ),
                  ],
                ),

                SizedBox(
                  width: double.infinity,
                  height: MyResponsive.height(context, value: 30),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          MyResponsive.radius(context, value: 100),
                        ),
                      ),
                    ),
                    child: Text(
                      status,
                      style: AppTextStyles.medium13(
                        context,
                      ).copyWith(color: AppColors.buttonTextOnPrimary),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
