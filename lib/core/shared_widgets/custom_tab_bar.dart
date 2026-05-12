import 'package:flower_app/core/utils/app_colors.dart';
import 'package:flower_app/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class CategoryTabBar extends StatefulWidget {
  final List categories;
  final int selectedIndex;
  final Function(int index) onTap;

  const CategoryTabBar({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  State<CategoryTabBar> createState() => _CategoryTabBarState();
}

class _CategoryTabBarState extends State<CategoryTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: widget.categories.length,
      vsync: this,
      initialIndex: widget.selectedIndex,
    );

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        widget.onTap(_tabController.index);
      }
    });
  }

  @override
  void didUpdateWidget(covariant CategoryTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.categories.length != widget.categories.length) {
      _tabController.dispose();

      _tabController = TabController(
        length: widget.categories.length,
        vsync: this,
        initialIndex: widget.selectedIndex,
      );
    }

    if (_tabController.index != widget.selectedIndex) {
      _tabController.animateTo(widget.selectedIndex);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final tabs = ['All', ...widget.categories];

    return TabBar(
      controller: _tabController,
      isScrollable: true,
      tabAlignment: TabAlignment.start,
      padding: EdgeInsets.zero,
      labelPadding: const EdgeInsets.only(right: 24),

      indicatorColor: AppColors.primaryColor,
      labelColor: AppColors.primaryColor,
      unselectedLabelColor: AppColors.textHint,

      tabs: List.generate(
        tabs.length,
            (index) {

          final isSelected = index == widget.selectedIndex;

          final title = index == 0 ? 'All' : tabs[index].name ?? "";

          return Tab(
            child: Text(
              title,
              style: AppTextStyles.regular16(context).copyWith(
                color: isSelected
                    ? AppColors.primaryColor
                    : AppColors.textHint,
                fontWeight: isSelected
                    ? FontWeight.bold
                    : FontWeight.w400,
              ),
            ),
          );
        },
      ),
    );
  }
}