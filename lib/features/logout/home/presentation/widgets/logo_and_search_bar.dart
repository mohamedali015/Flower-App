import 'package:flower_app/core/helpers/my_responsive.dart';
import 'package:flower_app/core/localization/l10n/app_localizations.dart';
import 'package:flower_app/core/utils/app_assets.dart';
import 'package:flutter/material.dart';

import '../../../../../core/shared_widgets/custom_search_bar.dart';

class LogoAndSearchBar extends StatelessWidget {
  const LogoAndSearchBar({super.key, required this.local});

  final AppLocalizations local;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          AppAssets.logo,
          height: MyResponsive.height(context, value: 25),
          width: MyResponsive.width(context, value: 90),
        ),
        SizedBox(width: MyResponsive.width(context, value: 17)),
        const CustomSearchBar(),
      ],
    );
  }
}
