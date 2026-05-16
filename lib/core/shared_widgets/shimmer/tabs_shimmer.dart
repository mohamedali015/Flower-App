import 'package:flutter/material.dart';
import 'package:flower_app/core/helpers/my_responsive.dart';
import 'package:flower_app/core/shared_widgets/shimmer_box.dart';

class TabsShimmer extends StatelessWidget {
  const TabsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        SizedBox(height: MyResponsive.height(context, value: 20)),
        SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (_, __) {
              return ShimmerBox(
                height: 35,
                width: 80,
                radius: 20,
              );
            },
          ),
        ),

        SizedBox(height: MyResponsive.height(context, value: 20)),


      ],
    );
  }
}