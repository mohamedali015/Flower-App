import 'package:flutter/material.dart';

import '../../../../../core/helpers/my_responsive.dart';
import '../../../../../core/shared_widgets/shimmer_box.dart';

class HomeShimmerLoading extends StatelessWidget {
  const HomeShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///? Categories Headline
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerBox(
                height: 20,
                width: MyResponsive.width(context, value: 120),
              ),
              ShimmerBox(
                height: 20,
                width: MyResponsive.width(context, value: 60),
              ),
            ],
          ),

          SizedBox(height: MyResponsive.height(context, value: 16)),

          ///? Categories List
          SizedBox(
            height: MyResponsive.height(context, value: 110),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              separatorBuilder: (_, _) =>
                  SizedBox(width: MyResponsive.width(context, value: 12)),
              itemBuilder: (_, _) {
                return Column(
                  children: [
                    ShimmerBox(
                      height: MyResponsive.height(context, value: 70),
                      width: MyResponsive.width(context, value: 70),
                      radius: 50,
                    ),
                    SizedBox(height: MyResponsive.height(context, value: 8)),
                    ShimmerBox(
                      height: 12,
                      width: MyResponsive.width(context, value: 50),
                    ),
                  ],
                );
              },
            ),
          ),

          SizedBox(height: MyResponsive.height(context, value: 24)),

          ///? Best Seller Headline
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerBox(
                height: 20,
                width: MyResponsive.width(context, value: 140),
              ),
              ShimmerBox(
                height: 20,
                width: MyResponsive.width(context, value: 60),
              ),
            ],
          ),

          SizedBox(height: MyResponsive.height(context, value: 16)),

          ///? Best Seller Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: .62,
            ),
            itemBuilder: (_, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(child: ShimmerBox(height: double.infinity)),

                  SizedBox(height: MyResponsive.height(context, value: 8)),

                  const ShimmerBox(height: 14, width: 100),

                  SizedBox(height: MyResponsive.height(context, value: 6)),

                  const ShimmerBox(height: 14, width: 70),
                ],
              );
            },
          ),

          SizedBox(height: MyResponsive.height(context, value: 24)),

          ///? Occasions Headline
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerBox(
                height: 20,
                width: MyResponsive.width(context, value: 120),
              ),
              ShimmerBox(
                height: 20,
                width: MyResponsive.width(context, value: 60),
              ),
            ],
          ),

          SizedBox(height: MyResponsive.height(context, value: 16)),

          ///? Occasions List
          SizedBox(
            height: MyResponsive.height(context, value: 180),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              separatorBuilder: (_, _) =>
                  SizedBox(width: MyResponsive.width(context, value: 12)),
              itemBuilder: (_, _) {
                return ShimmerBox(
                  height: MyResponsive.height(context, value: 180),
                  width: MyResponsive.width(context, value: 150),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
