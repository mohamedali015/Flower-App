import 'package:flower_app/core/utils/app_colors.dart';
import 'package:flower_app/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../helpers/my_responsive.dart';
import '../values/app_strings.dart';

class CategoryTabBar extends StatelessWidget {
  final List categories;
  final int selectedIndex;
  final Function(int index) onTap;

  const CategoryTabBar({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final itemCount = categories.length + 1;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(itemCount, (index) {
          final isSelected = index == selectedIndex;
          final isAll = index == 0;
          final category = isAll ? null : categories[index - 1];

          return GestureDetector(
            onTap: () => onTap(index),
            child: Padding(
              padding: MyResponsive.paddingOnly(context, end: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isAll ? AppStrings.all : category.name,
                    style: AppTextStyles.regular16(context).copyWith(
                      color: isSelected
                          ? AppColors.primaryColor
                          : AppColors.textHint,
                      fontWeight:
                      isSelected ? FontWeight.bold : FontWeight.w400,
                    ),
                  ),

                  SizedBox(height: MyResponsive.height(context, value: 8)),

                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: MyResponsive.height(context, value: 4),
                    width: 30,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primaryColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}