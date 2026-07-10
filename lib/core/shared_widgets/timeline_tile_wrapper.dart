import 'package:flower_app/features/track_order/domain/enums/order_status_enum.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class TimelineTileWrapper extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final OrderStatus? status;
  final OrderStatus? currentStatus;
  final OrderStatus? nextStatus;
  final String? label;
  final Widget? indicator;
  final Widget? endChild;
  final double lineThickness;
  final Color activeColor;
  final Color inactiveColor;

  const TimelineTileWrapper({
    super.key,
    this.isFirst = false,
    this.isLast = false,
    this.status,
    this.currentStatus,
    this.nextStatus,
    this.label,
    this.indicator,
    this.endChild,
    this.lineThickness = 1.0,
    this.activeColor = AppColors.primaryColor,
    this.inactiveColor = AppColors.grayDark,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPast = status != null && currentStatus != null
        ? currentStatus!.index >= status!.index
        : false;

    final bool nextIsPast = nextStatus != null && currentStatus != null
        ? currentStatus!.index >= nextStatus!.index
        : false;

    return TimelineTile(
      isFirst: isFirst,
      isLast: isLast,
      beforeLineStyle: LineStyle(
        color: isPast ? activeColor : inactiveColor,
        thickness: lineThickness,
      ),
      afterLineStyle: LineStyle(
        color: nextIsPast ? activeColor : inactiveColor,
        thickness: lineThickness,
      ),
      indicatorStyle: IndicatorStyle(
        width: 25,
        height: 25,
        drawGap: true,
        indicator:
            indicator ??
            Icon(
              isPast ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isPast ? activeColor : AppColors.grayNeutral,
              size: 25,
            ),
      ),
      endChild:
          endChild ??
          (label != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  child: Text(
                    label!,
                    style: AppTextStyles.medium16(context).copyWith(
                      color: isPast
                          ? AppColors.black100
                          : AppColors.grayNeutral,
                    ),
                  ),
                )
              : null),
    );
  }
}
