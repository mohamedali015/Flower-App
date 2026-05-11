import 'package:flutter/material.dart';
import '../../../../core/localization/l10n/app_localizations.dart';
class CategoryTabs extends StatelessWidget {
  final TabController controller;

  const CategoryTabs({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    return TabBar(
      controller: controller,
      tabs: [
        Tab(text: local.login),
        Tab(text: local.lastName),
        Tab(text: local.firstName),
      ],
    );
  }
}