import 'package:flower_app/core/helpers/my_responsive.dart';
import 'package:flutter/material.dart';

import '../../../../core/shared_widgets/custom_add_to_cart.dart';
import '../../../../core/shared_widgets/custom_grid_view.dart';
import '../../../../core/shared_widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MyResponsive.paddingAll(context, value: 8),
      child: Column(
        children: [
          // Expanded(
          //    child: CustomGridView(
          //       itemCount: 3,
          //       itemBuilder: (context, index) {
          //         // final product = state.products[index];
          //
          //         return ProductCard(
          //           product: ,
          //           onAddToCart: () {},
          //         );
          //       },
          //     )
          // ),
          CustomAddToCart(),
        ],
      ),
    );
  }
}
