import 'package:flower_app/core/helpers/my_responsive.dart';
import 'package:flower_app/core/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/localization/l10n/app_localizations.dart';
import '../../../../core/utils/app_text_styles.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;

    return Scaffold(
      body: Padding(
        padding: MyResponsive.paddingAll(context, value: 10),
        child: Column(
          children: [
            SizedBox(
              height: MyResponsive.height(context, value: 50),
            ),

            SearchBar(
              onChanged: (value) {},
              leading: Icon(
                CupertinoIcons.search,
                color: AppColors.textHint,
              ),
              trailing: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.cancel,
                    color: AppColors.textHint,
                  ),
                ),
              ],
              hintText: local.search,
              onSubmitted: (value) {
                FocusScope.of(context).unfocus();
              },
            ),

            Expanded(
              child: Center(
                child: Text(
                  local.searchForAnyProductYouWant,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.medium14(context).copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}