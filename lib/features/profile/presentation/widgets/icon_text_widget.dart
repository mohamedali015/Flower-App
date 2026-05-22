import 'package:flower_app/core/helpers/my_responsive.dart';
import 'package:flutter/material.dart';

import '../../../../core/shared_widgets/svg_wrapper.dart';
import '../../../../core/utils/app_text_styles.dart';

class IconTextWidget extends StatelessWidget {
  const IconTextWidget({required this.text, required this.iconPath});

  final String text;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgWrapper(path: iconPath),

        Padding(
          padding: MyResponsive.paddingSymmetric(context, horizontal: 2),
          child: Text(
            text,
            style: AppTextStyles.regular14(context).copyWith(fontSize: 13),
          ),
        ),
      ],
    );
  }
}
