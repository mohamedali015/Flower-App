import 'package:flutter/material.dart';

import '../../features/cart/presentation/screens/cart_screen.dart';
import '../../features/category/presentation/screens/category_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../localization/l10n/app_localizations.dart';
import '../shared_widgets/svg_wrapper.dart';
import '../utils/app_assets.dart';
import '../utils/app_colors.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({
    super.key,
    this.initialIndex = 0,
    this.categoryIndex = 0,
  });

  final int initialIndex;
  final int categoryIndex;

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  late int currentIndex;

  late int selectedCategoryIndex;

  @override
  void initState() {
    super.initState();

    currentIndex = widget.initialIndex;

    selectedCategoryIndex = widget.categoryIndex;
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    final screens = [
      const HomeScreen(),
      CategoryScreen(initialIndex: selectedCategoryIndex),
      const CartScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(

      body: IndexedStack(index: currentIndex, children: screens),

      bottomNavigationBar: BottomNavigationBar(

        currentIndex: currentIndex,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },


        items: [
          BottomNavigationBarItem(
            icon: SvgWrapper(
              path: AppAssets.homeIcon,
              color: currentIndex == 0
                  ? AppColors.primaryColor
                  : AppColors.disabledGray,
            ),

            label: local.home,
          ),

          BottomNavigationBarItem(
            icon: SvgWrapper(
              path: AppAssets.categoryIcon,
              color: currentIndex == 1
                  ? AppColors.primaryColor
                  : AppColors.disabledGray,
            ),

            label: local.categories,
          ),

          BottomNavigationBarItem(
            icon: SvgWrapper(
              path: AppAssets.shoppingIcon,
              color: currentIndex == 2
                  ? AppColors.primaryColor
                  : AppColors.disabledGray,
            ),

            label: local.cart,
          ),

          BottomNavigationBarItem(
            icon: SvgWrapper(
              path: AppAssets.personIcon,
              color: currentIndex == 3
                  ? AppColors.primaryColor
                  : AppColors.disabledGray,
            ),

            label: local.profile,
          ),
        ],
      ),
    );
  }
}
