import 'package:flower_app/core/utils/app_colors.dart';
import 'package:flower_app/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import '../helpers/my_responsive.dart';

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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(categories.length, (index) {
          final isSelected = index == selectedIndex;
          final category = categories[index];

          return GestureDetector(
            onTap: () => onTap(index),
            child: Padding(
              padding: MyResponsive.paddingOnly(context, end: 24),
              child: IntrinsicWidth(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    Text(
                      category.name ?? "",
                      style: AppTextStyles.regular16(context).copyWith(
                        color: isSelected
                            ? AppColors.primaryColor
                            : AppColors.textHint,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.w400,
                      ),
                    ),

                    SizedBox(height: MyResponsive.height(context, value: 8)),

                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      height: MyResponsive.height(context, value: 4),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primaryColor
                            : AppColors.textHint,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            MyResponsive.radius(context, value: 8),
                          ),
                          topRight: Radius.circular(
                            MyResponsive.radius(context, value: 8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
