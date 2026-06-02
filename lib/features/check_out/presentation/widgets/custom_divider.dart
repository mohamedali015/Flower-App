import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
    this.height = 24,
    this.thickness = 30,
    this.color = AppColors.darkShade7,
  });

  final double height;
  final double thickness;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Divider(height: height, thickness: thickness, color: color);
  }
}
