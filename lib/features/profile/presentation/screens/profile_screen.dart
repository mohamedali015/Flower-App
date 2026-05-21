import 'package:flower_app/config/route_manager/routes.dart';
import 'package:flower_app/config/secure_cache/secure_cache/cache_keys.dart';
import 'package:flower_app/config/secure_cache/secure_cache/secure_cache.dart';
import 'package:flower_app/core/shared_widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../../../../config/di/di.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Profile Screen"),
          const SizedBox(height: 40),
          CustomButton(
            title: "Logout",
            onPressed: () async {
              final secureCache = getIt<SecureCache>();
              await secureCache.removeData(key: CacheKeys.token);
              await secureCache.removeData(key: CacheKeys.rememberMe);

              if (!context.mounted) return;

              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.loginRoute,
                (route) => false,
              );
            },
          ),
          const SizedBox(height: 24),
          CustomButton(
            title: "EditProfile",
            onPressed: () {
              Navigator.pushNamed(context, Routes.editProfileScreenRoute);
            },
          ),
        ],
      ),
    );
  }
}
