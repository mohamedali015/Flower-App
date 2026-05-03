import 'package:flower_app/core/shared_widgets/svg_wrapper.dart';
import 'package:flutter/material.dart';
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
    // HomeScreen(),
    // ResultsScreen(),
    // ProfileScreen(),
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
        currentIndex: currentIndex,
        onTap: _onTap,
        items: [
          ////////// Add name & image (using image SVG)

          // _buildItem(AppAssets.homePath, AppStrings.home, 0),
          // _buildItem(AppAssets.resultPath, AppStrings.result, 1),
          // _buildItem(AppAssets.profilePath, AppStrings.profile, 2),
          // _buildItem(AppAssets.profilePath, AppStrings.profile, 3),
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
      padding: MyResponsive.paddingSymmetric(
        vertical: 8,
        horizontal: 20,
        context,
      ),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryColor : Colors.transparent,
        borderRadius: BorderRadius.circular(
          MyResponsive.radius(value: 16, context),
        ),
      ),
      child: SvgWrapper(
        path: image,
        width: MyResponsive.width(value: 16, context),
        height: MyResponsive.height(value: 16, context),
        fit: BoxFit.contain,
        color: isSelected ? AppColors.primaryColor : AppColors.disabledGray,
      ),
    );
  }
}
