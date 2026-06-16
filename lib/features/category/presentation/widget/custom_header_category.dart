import 'package:flower_app/core/values/app_strings.dart';
import 'package:flower_app/features/filter/data/extentions/sort_option_api.dart';
import 'package:flower_app/features/filter/domain/enums/sort_options.dart';
import 'package:flower_app/features/filter/presentation/widget/filter_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_app/core/localization/l10n/app_localizations.dart';

import '../../../../config/products/data/params/product_query_params.dart';
import '../../../../core/helpers/my_responsive.dart';
import '../../../../core/shared_widgets/custom_search_bar.dart';
import '../../../../core/shared_widgets/svg_wrapper.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../manager/category_cubit.dart';
import '../manager/category_event.dart';

class CustomHeaderCategory extends StatelessWidget {
  final String currentCategoryId;

  const CustomHeaderCategory({super.key, required this.currentCategoryId});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CustomSearchBar(horizontal: 20, vertical: 15),
        SizedBox(width: MyResponsive.width(context, value: 8)),
        GestureDetector(
          onTap: () async {
            final SortOption? selectedSort = await showFilterBottomSheet(
              context,
            );

            if (selectedSort != null && context.mounted) {
              final cubit = context.read<CategoryCubit>();

              cubit.doEvent(
                ProductEvent(
                  categoryId: ProductQueryParams(
                    categoryId: currentCategoryId,
                    sort: selectedSort,
                  ),
                ),
              );
            }
          },
          child: Container(
            padding: MyResponsive.paddingSymmetric(
              context,
              horizontal: 20,
              vertical: 15,
            ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(
                MyResponsive.radius(context, value: 8),
              ),
              border: Border.all(
                color: AppColors.textHint,
                width: MyResponsive.width(context, value: 1.5),
              ),
            ),
            child: SvgWrapper(
              path: AppAssets.sortIcons,
              width: MyResponsive.width(value: 18, context),
              height: MyResponsive.height(value: 12, context),
              fit: BoxFit.contain,
              color: AppColors.textHint,
            ),
          ),
        ),
      ],
    );
  }

  String _mapToApiKey(String localOption, AppLocalizations local) {
    final map = {
      local.lowestPrice: AppStrings.priceAsc,
      local.highestPrice: AppStrings.priceDesc,
      local.newest: AppStrings.newest,
      local.old: AppStrings.oldest,
      local.discount: AppStrings.discount,
    };

    return map[localOption] ?? '';
  }
}

Future<SortOption?> showFilterBottomSheet(BuildContext context) {
  final cubit = context.read<CategoryCubit>();

  final currentSort = mapApiKeyToSort(cubit.state.selectedSortOption?.apiKey);

  return showModalBottomSheet<SortOption>(
    context: context,
    isScrollControlled: true,
    builder: (context) => FilterSheet(currentSort: currentSort),
  );
}
