import 'package:flutter/material.dart';

import '../../helpers/my_responsive.dart';
import '../shimmer_box.dart';

class BottomPaginationShimmer extends StatelessWidget {
  const BottomPaginationShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 2,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 163 / 229,
      ),
      itemBuilder: (_, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ShimmerBox(
                height: MyResponsive.height(context, value: double.infinity),
              ),
            ),
            SizedBox(height: MyResponsive.height(context, value: 8)),
            ShimmerBox(
              height: MyResponsive.height(context, value: 14),
              width: MyResponsive.width(context, value: 100),
            ),
            SizedBox(height: MyResponsive.height(context, value: 6)),
            ShimmerBox(
              height: MyResponsive.height(context, value: 14),
              width: MyResponsive.width(context, value: 16),
            ),
          ],
        );
      },
    );
  }
}
