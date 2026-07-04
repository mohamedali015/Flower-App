import 'package:flutter/cupertino.dart';

import '../../../../core/helpers/my_responsive.dart';
import '../../../../core/shared_widgets/shimmer_box.dart';

class LocationBarShimmer extends StatelessWidget {
  const LocationBarShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MyResponsive.paddingSymmetric(
        context,
        vertical: 17,
      ),
      child: Row(
        children: [
          ShimmerBox(
            height: MyResponsive.height(context, value: 20),
            width: MyResponsive.width(context, value: 20),
            radius: 20,
          ),

          SizedBox(
            width: MyResponsive.width(context, value: 8),
          ),

          ShimmerBox(
            height: MyResponsive.height(context, value: 14),
            width: MyResponsive.width(context, value: 140),
          ),

          SizedBox(
            width: MyResponsive.width(context, value: 8),
          ),

          ShimmerBox(
            height: MyResponsive.height(context, value: 16),
            width: MyResponsive.width(context, value: 16),
            radius: 16,
          ),
        ],
      ),
    );
  }
}