import 'package:flutter/material.dart';

import '../../../../core/shared_widgets/custom_bottom_nav.dart';

class AppSectionScreen extends StatelessWidget {
  const AppSectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(bottomNavigationBar: CustomBottomNavBar());
  }
}
