import 'package:flower_app/core/localization/l10n/app_localizations.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_text_styles.dart';

class TermsAndConditionsWidget extends StatelessWidget {
  const TermsAndConditionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: local.termsText,
            style: AppTextStyles.regular12(context),
          ),
          const TextSpan(text: ' '),
          TextSpan(
            text: local.termsAndConditions,
            style: AppTextStyles.semiBold12(
              context,
            ).copyWith(decoration: TextDecoration.underline),
            recognizer: TapGestureRecognizer()..onTap = () {},
          ),
        ],
      ),
      textAlign: TextAlign.start,
    );
  }
}
