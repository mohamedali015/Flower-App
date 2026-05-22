import 'package:flutter/material.dart';

import '../../features/cart/presentation/screens/cart_screen.dart';
import '../../features/category/presentation/screens/category_screen.dart';
import '../../features/logout/home/presentation/screens/home_screen.dart';
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

  late final List<Widget> screens;

  @override
  void initState() {
    super.initState();

    currentIndex = widget.initialIndex;

    screens = [
      const _KeepAlivePage(child: HomeScreen()),

      _KeepAlivePage(child: CategoryScreen(initialIndex: widget.categoryIndex)),

      const _KeepAlivePage(child: CartScreen()),

      const _KeepAlivePage(child: ProfileScreen()),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      body: IndexedStack(index: currentIndex, children: screens),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (int index) {
          if (currentIndex == index) return;
          setState(() {
            currentIndex = index;
          });
        },

        destinations: [
          NavigationDestination(
            icon: const _BottomNavIcon(
              path: AppAssets.homeIcon,
              isSelected: false,
            ),

            selectedIcon: const _BottomNavIcon(
              path: AppAssets.homeIcon,
              isSelected: true,
            ),

            label: local.home,
          ),

          NavigationDestination(
            icon: const _BottomNavIcon(
              path: AppAssets.categoryIcon,
              isSelected: false,
            ),

            selectedIcon: const _BottomNavIcon(
              path: AppAssets.categoryIcon,
              isSelected: true,
            ),

            label: local.categories,
          ),

          NavigationDestination(
            icon: const _BottomNavIcon(
              path: AppAssets.cartIcon,
              isSelected: false,
            ),

            selectedIcon: const _BottomNavIcon(
              path: AppAssets.cartIcon,
              isSelected: true,
            ),

            label: local.cart,
          ),

          NavigationDestination(
            icon: const _BottomNavIcon(
              path: AppAssets.personIcon,
              isSelected: false,
            ),

            selectedIcon: const _BottomNavIcon(
              path: AppAssets.personIcon,
              isSelected: true,
            ),

            label: local.profile,
          ),
        ],
      ),
    );
  }
}

class _BottomNavIcon extends StatelessWidget {
  const _BottomNavIcon({required this.path, required this.isSelected});

  final String path;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return SvgWrapper(
      path: path,
      width: 24,
      height: 24,
      color: isSelected ? AppColors.primaryColor : AppColors.disabledGray,
    );
  }
}

class _KeepAlivePage extends StatefulWidget {
  const _KeepAlivePage({required this.child});

  final Widget child;

  @override
  State<_KeepAlivePage> createState() => _KeepAlivePageState();
}

class _KeepAlivePageState extends State<_KeepAlivePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
