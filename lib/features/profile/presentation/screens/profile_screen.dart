import 'package:flower_app/config/route_manager/routes.dart';

import 'package:flower_app/core/shared_widgets/custom_button.dart';
import 'package:flutter/material.dart';

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
              Navigator.pushNamed(context, Routes.changePasswordRoute);
            },
          ),
        ],
      ),
    );
  }
}
