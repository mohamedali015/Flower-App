import 'package:flower_app/core/helpers/my_responsive.dart';
import 'package:flower_app/core/localization/l10n/app_localizations.dart';
import 'package:flower_app/core/utils/app_colors.dart';
import 'package:flower_app/core/utils/app_text_styles.dart';
import 'package:flower_app/features/filter/domain/enums/sort_options.dart';
import 'package:flower_app/features/filter/presentation/extentions/sort_option_ui.dart';
import 'package:flutter/material.dart';

class FilterSheet extends StatefulWidget {
  final SortOption? currentSort;

  const FilterSheet({super.key, this.currentSort});

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  SortOption? _selectedOption;

  @override
  void initState() {
    super.initState();
    _selectedOption = widget.currentSort;
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    const options = SortOption.values;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.baseWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(MyResponsive.radius(context, value: 32)),
          topRight: Radius.circular(MyResponsive.radius(context, value: 32)),
        ),
      ),
      padding: MyResponsive.paddingAll(context, value: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: MyResponsive.width(context, value: 80),
              height: MyResponsive.height(context, value: 5),
              decoration: BoxDecoration(
                color: AppColors.grayDeeper,
                borderRadius: BorderRadius.circular(
                  MyResponsive.radius(context, value: 2.5),
                ),
              ),
            ),
          ),
          SizedBox(height: MyResponsive.height(context, value: 16)),

          Text(
            local.sortBy,
            style: AppTextStyles.bold20(
              context,
            ).copyWith(color: AppColors.primaryColor),
          ),
          SizedBox(height: MyResponsive.height(context, value: 16)),

          Column(
            children: options.map((option) {
              final isSelected = _selectedOption == option;

              return Padding(
                padding: MyResponsive.paddingOnly(context, bottom: 12),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedOption = option;
                    });
                  },
                  child: Container(
                    padding: MyResponsive.paddingSymmetric(
                      context,
                      horizontal: 16,
                      vertical: 18,
                    ),

                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(
                        MyResponsive.radius(context, value: 16),
                      ),
                      boxShadow: const [
                        BoxShadow(color: AppColors.grayLight, blurRadius: 5),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          option.label(local),
                          style: AppTextStyles.medium16(context),
                        ),
                        Container(
                          width: MyResponsive.width(context, value: 20),
                          height: MyResponsive.height(context, value: 20),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.primaryColor,
                              width: 2,
                            ),
                          ),
                          child: isSelected
                              ? Center(
                                  child: Container(
                                    width: MyResponsive.width(
                                      context,
                                      value: 12,
                                    ),
                                    height: MyResponsive.height(
                                      context,
                                      value: 12,
                                    ),
                                    decoration: const BoxDecoration(
                                      color: AppColors.primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                )
                              : null,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: MyResponsive.height(context, value: 16)),

          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context, _selectedOption);
            },
            icon: const Icon(Icons.tune, color: Colors.white, size: 20),
            label: Text(local.filter),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}
