import 'package:flutter/material.dart';

import '../../../../core/shared_widgets/svg_wrapper.dart';
import '../../../../core/utils/app_text_styles.dart';

class IconTextWidget extends StatelessWidget {
  const IconTextWidget({super.key, required this.text, required this.iconPath});

  final String text;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgWrapper(path: iconPath, width: 20, height: 20),
        const SizedBox(width: 4),
        Text(text, style: AppTextStyles.regular13(context)),
      ],
    );
  }
}
