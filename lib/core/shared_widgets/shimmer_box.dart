import 'package:flower_app/core/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';

import '../helpers/my_responsive.dart';

class ShimmerBox extends StatelessWidget {
  final double height;
  final double width;
  final double radius;

  const ShimmerBox({
    super.key,
    required this.height,
    this.width = double.infinity,
    this.radius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: AppColors.textHint,
        borderRadius: BorderRadius.circular(
          MyResponsive.radius(context, value: radius),
        ),
      ),
    );
  }
}
