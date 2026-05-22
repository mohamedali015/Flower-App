import 'package:flower_app/config/products/domain/entities/product_entity.dart';
import 'package:flower_app/config/route_manager/routes.dart';
import 'package:flower_app/core/helpers/my_responsive.dart';
import 'package:flower_app/features/home/presentation/widgets/home_list_card.dart';
import 'package:flutter/widgets.dart';

class BestSellerList extends StatelessWidget {
  final List<ProductEntity> items;
  const BestSellerList({super.key, required this.items});

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
                context,
                Routes.productDetailsRoute,
                arguments: item,
              );
            },
            child: HomeListCard(
              title: item.title,
              price: item.price.toInt(),
              image: item.imgCover,
            ),
          );
        },
      ),
    );
  }
}
