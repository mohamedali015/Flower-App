import 'package:flower_app/config/route_manager/routes.dart';
import 'package:flower_app/core/helpers/my_responsive.dart';
import 'package:flower_app/core/utils/app_text_styles.dart';
import 'package:flower_app/features/home/domain/entities/occasions_entity.dart';
import 'package:flower_app/features/home/presentation/widgets/home_list_card.dart';
import 'package:flutter/material.dart';

class OccasionsList extends StatelessWidget {
  final List<OccasionsEntity> items;
  const OccasionsList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final itemCount = items.length > 6 ? 6 : items.length;
    return SizedBox(
      height: MyResponsive.height(context, value: 210),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          final item = items[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                  context, Routes.occasionRoute, arguments: index);
            },
            child: HomeListCard(
              title: item.name,
              image: item.image,
              titleStyle: AppTextStyles.medium14(context),
            ),
          );
        },
      ),
    );
  }
}
