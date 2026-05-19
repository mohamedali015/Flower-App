import 'package:flower_app/config/route_manager/routes.dart';
import 'package:flower_app/config/secure_cache/secure_cache/cache_keys.dart';
import 'package:flower_app/config/secure_cache/secure_cache/secure_cache.dart';
import 'package:flower_app/core/helpers/my_responsive.dart';
import 'package:flower_app/core/localization/l10n/app_localizations.dart';
import 'package:flower_app/core/shared_widgets/svg_wrapper.dart';
import 'package:flower_app/core/utils/app_assets.dart';
import 'package:flower_app/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../../../config/di/di.dart';
import '../../../../core/utils/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Padding(
      padding: MyResponsive.paddingSymmetric(context, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Placeholder(),
          const Divider(color: AppColors.hintTextGray ,endIndent: 0,),
          TextButton.icon(
            onPressed: () => _onPress(context),
            icon: const SvgWrapper(path: AppAssets.logout),
            label: Text(
              local.logout,
              style: AppTextStyles.regular14(context).copyWith(fontSize: 13),
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
