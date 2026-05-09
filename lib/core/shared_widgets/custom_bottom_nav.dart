import 'package:flower_app/core/shared_widgets/svg_wrapper.dart';
import 'package:flutter/material.dart';

import '../../feautre/cart/presentation/screens/cart_screen.dart';
import '../../feautre/category/presentation/screens/category_screen.dart';
import '../../feautre/home/presentation/screens/home_screen.dart';
import '../../feautre/profile/presentation/screens/profile_screen.dart';
import '../helpers/my_responsive.dart';
import '../localization/l10n/app_localizations.dart';
import '../utils/app_assets.dart';
import '../utils/app_colors.dart';


class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  late int currentIndex;

  final List<Widget> _screens = const [
    HomeScreen(),
    CategoryScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  void _onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    return Scaffold(
      body: IndexedStack(index: currentIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: _onTap,
        items: [
          _buildItem(AppAssets.homeIcon, local.home, 0),
          _buildItem(AppAssets.categoryIcon, local.categories, 1),
          _buildItem(AppAssets.shoppingIcon, local.cart, 2),
          _buildItem(AppAssets.personIcon, local.profile, 3),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildItem(String image, String label, int index) {
    return BottomNavigationBarItem(
      icon: _NavIcon(image: image, isSelected: currentIndex == index),
      label: label,
    );
  }
}

class _NavIcon extends StatelessWidget {
  const _NavIcon({required this.image, required this.isSelected});

  final String image;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: MyResponsive.paddingSymmetric(vertical: 8, horizontal: 20,context),
      child: SvgWrapper(
        path: image,
        width: MyResponsive.width(value: 25,context),
        height: MyResponsive.height(value: 25,context),
        fit: BoxFit.contain,
        color: isSelected ? AppColors.primaryColor : AppColors.disabledGray,
      ),
    );
  }
}







