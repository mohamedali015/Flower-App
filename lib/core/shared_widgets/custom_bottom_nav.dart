import 'package:flutter/material.dart';

import '../../feautre/cart/presentation/screens/cart_screen.dart';
import '../../feautre/category/presentation/screens/category_screen.dart';
import '../../feautre/home/presentation/screens/home_screen.dart';
import '../../feautre/profile/presentation/screens/profile_screen.dart';
import '../helpers/my_responsive.dart';
import '../utils/app_assets.dart';
import '../utils/app_colors.dart';
import '../values/app_strings.dart';

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
    return Scaffold(
      body: IndexedStack(index: currentIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.buttonTextOnPrimary,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: _onTap,
        items: [
          ////////// Add name & image (using image SVG)
          _buildItem(
            unselectedImage: AppAssets.unselectedHomeIcon,
            label: AppStrings.home,
            selectedImage: AppAssets.selectedHomeIcon,
            index: 0,
          ),
          _buildItem(
            unselectedImage: AppAssets.unselectedCategoryIcon,
            label: AppStrings.category,
            index: 1,
            selectedImage: AppAssets.selectedCategoryIcon,
          ),
          _buildItem(
            unselectedImage: AppAssets.unselectedCartIcon,
            label: AppStrings.cart,
            index: 2,
            selectedImage: AppAssets.selectedCartIcon,
          ),
          _buildItem(
            unselectedImage: AppAssets.unselectedProfileIcon,
            label: AppStrings.profile,
            index: 3,
            selectedImage: AppAssets.selectedProfileIcon,
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildItem({
    required String unselectedImage,
    required String selectedImage,
    required String label,
    required int index,
  }) {
    bool isSelected = currentIndex == index;
    return BottomNavigationBarItem(
      icon: _NavIcon(
        image: isSelected ? selectedImage : unselectedImage,
        isSelected: isSelected,
      ),
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
      padding: MyResponsive.paddingSymmetric(
        vertical: 8,
        horizontal: 20,
        context,
      ),
      decoration: BoxDecoration(
        // color: isSelected ? AppColors.primaryColor : Colors.transparent,
        borderRadius: BorderRadius.circular(
          MyResponsive.radius(value: 16, context),
        ),
      ),
      child: Image.asset(
        image,
        width: MyResponsive.width(value: 24, context),
        height: MyResponsive.height(value: 24, context),
        fit: BoxFit.contain,
        // color: isSelected ? AppColors.primaryColor : AppColors.disabledGray,
      ),
    );
  }
}
