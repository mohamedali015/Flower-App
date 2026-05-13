import 'package:flower_app/core/helpers/my_responsive.dart';
import 'package:flower_app/core/utils/app_colors.dart';
import 'package:flower_app/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/occasion_entity.dart';

class OccasionTabsWidget extends StatelessWidget {
  const OccasionTabsWidget({
    super.key,
    required this.occasions,
    required this.onTap,
    required this.selectedIndex,
  });

  final List<OccasionEntity> occasions;

  final ValueChanged<int> onTap;

  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: occasions.length,

      child: TabBar(
        isScrollable: true,

        tabAlignment: TabAlignment.start,

        onTap: onTap,

        indicatorColor: Colors.transparent,

        dividerColor: Colors.transparent,

        overlayColor: WidgetStateProperty.all(Colors.transparent),

        splashFactory: NoSplash.splashFactory,

        labelPadding: MyResponsive.paddingOnly(context, end: 20),

        tabs: List.generate(occasions.length, (index) {
          final isSelected = selectedIndex == index;

          return Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              Text(
                occasions[index].name,

                style: AppTextStyles.regular16(context).copyWith(
                  color: isSelected
                      ? AppColors.primaryColor
                      : AppColors.textHint,
                ),
              ),

              SizedBox(height: MyResponsive.height(context, value: 8)),

              AnimatedContainer(
                duration: const Duration(milliseconds: 250),

                width: isSelected ? MyResponsive.width(context, value: 70) : 0,

                height: MyResponsive.height(context, value: 4),

                decoration: BoxDecoration(
                  color: AppColors.primaryColor,

                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      MyResponsive.radius(context, value: 100),
                    ),

                    topRight: Radius.circular(
                      MyResponsive.radius(context, value: 100),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
