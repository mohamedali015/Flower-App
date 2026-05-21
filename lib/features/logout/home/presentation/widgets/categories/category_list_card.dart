import 'package:flower_app/core/helpers/my_responsive.dart';
import 'package:flower_app/core/utils/app_colors.dart';
import 'package:flower_app/core/utils/app_text_styles.dart';
import 'package:flower_app/features/logout/home/domain/entities/categories_entity.dart';
import 'package:flutter/material.dart';

class CategoryListCard extends StatelessWidget {
  final CategoriesEntity category;

  const CategoryListCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: MyResponsive.height(context, value: 8),
      children: [
        Container(
          padding: MyResponsive.paddingSymmetric(
            context,
            horizontal: 22,
            vertical: 20,
          ),
          width: MyResponsive.width(context, value: 68),
          height: MyResponsive.height(context, value: 65),
          decoration: BoxDecoration(
            color: AppColors.lightPink,
            borderRadius: BorderRadius.circular(
              MyResponsive.radius(context, value: 20),
            ),
          ),
          child: Image.network(category.image!),
        ),
        Text(category.name ?? '', style: AppTextStyles.regular14(context)),
      ],
    );
  }
}
