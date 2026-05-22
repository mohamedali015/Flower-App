import 'package:flower_app/core/utils/app_text_styles.dart';
import 'package:flower_app/features/profile/presentation/widgets/profile_screen_setting_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/cubit/locale/locale_cubit.dart';
import '../../../../core/helpers/my_responsive.dart';
import '../../../../core/localization/l10n/app_localizations.dart';
import '../../../../core/shared_widgets/svg_wrapper.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import 'icon_text_widget.dart';

class ProfileScreenView extends StatefulWidget {
  @override
  State<ProfileScreenView> createState() => _ProfileScreenViewState();
}

class _ProfileScreenViewState extends State<ProfileScreenView> {
  bool switchState = true;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ProfileScreenSettingItemWidget(
              left: Image.asset(
                AppAssets.logo,
                height: MyResponsive.height(context, value: 25),
                width: MyResponsive.width(context, value: 90),
              ),
              right: IconButton(
                onPressed: () {},
                icon: const SvgWrapper(path: AppAssets.notification),
              ),
            ),

            ProfileScreenSettingItemWidget(
              left: IconTextWidget(
                text: locale.myOrders,
                iconPath: AppAssets.myOrders,
              ),
              right: IconButton(
                onPressed: () {},
                icon: const SvgWrapper(path: AppAssets.iosForwardBtn),
              ),
            ),
            ProfileScreenSettingItemWidget(
              left: IconTextWidget(
                text: locale.myAddress,
                iconPath: AppAssets.location,
              ),
              right: IconButton(
                onPressed: () {},
                icon: const SvgWrapper(path: AppAssets.iosForwardBtn),
              ),
            ),
            const Divider(color: AppColors.hintTextGray, endIndent: 0),
            Row(
              children: [
                Switch(
                  padding: MyResponsive.paddingSymmetric(
                    context,
                    horizontal: 4,
                  ),
                  activeTrackColor: AppColors.primaryColor,
                  value: switchState,
                  onChanged: (value) {
                    setState(() {
                      switchState = !switchState;
                    });
                  },
                ),
                Text(locale.notification),
              ],
            ),

            const Divider(color: AppColors.hintTextGray, endIndent: 0),
            ProfileScreenSettingItemWidget(
              left: IconTextWidget(
                text: locale.language,
                iconPath: AppAssets.language,
              ),
              right: IconButton(
                onPressed: () {},
                icon: const SvgWrapper(path: AppAssets.iosForwardBtn),
              ),
            ),

            ProfileScreenSettingItemWidget(
              left: Text(
                locale.aboutUs,
                style: AppTextStyles.regular14(context).copyWith(fontSize: 13),
              ),
              right: IconButton(
                onPressed: () {},
                icon: const SvgWrapper(path: AppAssets.iosForwardBtn),
              ),
            ),
            ProfileScreenSettingItemWidget(
              left: Text(
                locale.termsAndConditions,
                style: AppTextStyles.regular14(context).copyWith(fontSize: 13),
              ),
              right: IconButton(
                onPressed: () {},
                icon: const SvgWrapper(path: AppAssets.iosForwardBtn),
              ),
            ),
            const Divider(color: AppColors.hintTextGray, endIndent: 0),
            ProfileScreenSettingItemWidget(
              left: IconTextWidget(
                text: locale.logout,
                iconPath: AppAssets.logout,
              ),
              right: IconButton(
                onPressed: () {},
                icon: const SvgWrapper(path: AppAssets.logout),
              ),
            ),
            const Divider(color: AppColors.hintTextGray, endIndent: 0),
            //test to be removed
            Padding(
              padding: MyResponsive.paddingSymmetric(context, horizontal: 16),
              child: ElevatedButton(
                onPressed: () => _changeLocale(context),
                child: const Text("local test"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _changeLocale(BuildContext context) {
    final localeCubit = context.read<LocaleCubit>();
    final currentLocale = localeCubit.state.languageCode;
    localeCubit.changeLanguage(currentLocale == 'en' ? 'ar' : 'en');
  }
}
