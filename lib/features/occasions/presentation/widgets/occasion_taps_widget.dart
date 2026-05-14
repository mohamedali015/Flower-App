import 'package:flower_app/core/utils/app_colors.dart';
import 'package:flower_app/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/occasion_entity.dart';

class OccasionTabsWidget extends StatelessWidget {
  const OccasionTabsWidget({
    super.key,
    required this.occasions,
    required this.onTap,
  });

  final List<OccasionEntity> occasions;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: occasions.length,

      child: TabBar(
        isScrollable: true,

        tabAlignment: TabAlignment.start,

        onTap: onTap,

        indicatorColor: AppColors.primaryColor,

        indicatorPadding: EdgeInsets.symmetric(horizontal: 2),

        indicatorWeight: 4,

        indicatorSize: TabBarIndicatorSize.label,

        dividerColor: Colors.transparent,

        overlayColor: WidgetStateProperty.all(Colors.transparent),

        splashFactory: NoSplash.splashFactory,

        labelColor: AppColors.primaryColor,

        unselectedLabelColor: AppColors.textHint,

        labelStyle: AppTextStyles.regular16(context),

        unselectedLabelStyle: AppTextStyles.regular16(context),

        tabs: List.generate(
          occasions.length,
          (index) => Tab(text: occasions[index].name),
        ),
      ),
    );
  }
}
