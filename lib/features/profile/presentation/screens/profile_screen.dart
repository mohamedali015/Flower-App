import 'package:flower_app/config/route_manager/routes.dart';
import 'package:flower_app/config/secure_cache/secure_cache/cache_keys.dart';
import 'package:flower_app/config/secure_cache/secure_cache/secure_cache.dart';
import 'package:flower_app/config/user/manager/user_cubit.dart';
import 'package:flower_app/config/user/manager/user_events.dart';
import 'package:flower_app/core/helpers/my_responsive.dart';
import 'package:flower_app/core/localization/l10n/app_localizations.dart';
import 'package:flower_app/core/shared_widgets/svg_wrapper.dart';
import 'package:flower_app/core/utils/app_assets.dart';
import 'package:flower_app/features/profile/presentation/widgets/icon_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/di/di.dart';
import '../../../../core/cubit/locale/locale_cubit.dart';
import '../../../../core/utils/app_colors.dart';
import '../widgets/profile_screen_setting_item_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserCubit>();
    final localeCubit = context.read<LocaleCubit>();
    final locale = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Placeholder(),
          //orders / saved address
          const Divider(color: AppColors.hintTextGray, endIndent: 0),
          //notification
          const Divider(color: AppColors.hintTextGray, endIndent: 0),
          Padding(
            padding: MyResponsive.paddingSymmetric(context, horizontal: 16),
            child: const Placeholder(),
          ),
          const Divider(color: AppColors.hintTextGray, endIndent: 0),
          ProfileScreenSettingItemWidget(
            left: IconTextWidget(
              text: locale.logout,
              iconPath: AppAssets.logout,
            ),
            right: IconButton(
              onPressed: () => _onPress(context),
              icon: const SvgWrapper(path: AppAssets.logout),
            ),
          ),
          const Divider(color: AppColors.hintTextGray, endIndent: 0),
          //test to be removed
          Padding(
            padding: MyResponsive.paddingSymmetric(context, horizontal: 16),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    cubit.doEvent(GetUserDataEvent());
                  },
                  child: Text("APi Test"),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    final currentLocale = localeCubit.state.languageCode;
                    localeCubit.changeLanguage(
                      currentLocale == 'en' ? 'ar' : 'en',
                    );
                  },
                  child: const Text("local test"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onPress(BuildContext context) async {
    final secureCache = getIt<SecureCache>();
    await secureCache.removeData(key: CacheKeys.token);
    await secureCache.removeData(key: CacheKeys.rememberMe);
    if (!context.mounted) return;
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.loginRoute,
      (route) => false,
    );
  }
}
