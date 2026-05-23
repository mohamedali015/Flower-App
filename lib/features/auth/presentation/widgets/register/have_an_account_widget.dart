import 'package:flower_app/core/utils/app_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_text_styles.dart';

class HaveAnAccountWidget extends StatelessWidget {
  const HaveAnAccountWidget({
    super.key,
    required this.onTap,
    required this.title,
    required this.actionText,
  });

  final GestureTapCallback onTap;
  final String title;
  final String actionText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: title, style: AppTextStyles.regular16(context)),
            const TextSpan(text: ' '),
            TextSpan(
              text: actionText,
              style: AppTextStyles.medium16(context).copyWith(
                decoration: TextDecoration.underline,
                color: AppColors.primaryColor,
              ),
              recognizer: TapGestureRecognizer()..onTap = onTap,
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
