import 'package:flower_app/core/helpers/my_responsive.dart';
import 'package:flower_app/features/home/domain/entities/categories_entity.dart';
import 'package:flower_app/features/home/presentation/widgets/categories/category_list_card.dart';
import 'package:flutter/material.dart';

class CategoriesList extends StatelessWidget {
  final List<CategoriesEntity> categories;

  const CategoriesList({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    final itemCount = categories.length > 6 ? 6 : categories.length;
    return SizedBox(
      height: MyResponsive.height(context, value: 120),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          final category = categories[index];

          return Padding(
            padding: MyResponsive.paddingOnly(context, end: 16, top: 16),
            child: CategoryListCard(category: category),
          );
        },
      ),
    );
  }
}
