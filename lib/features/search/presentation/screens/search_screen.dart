import 'package:flower_app/core/helpers/my_responsive.dart';
import 'package:flower_app/core/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/products/data/params/product_query_params.dart';
import '../../../../core/localization/l10n/app_localizations.dart';
import '../../../../core/shared_widgets/custom_grid_view.dart';
import '../../../../core/shared_widgets/product_card.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../manager/search_cubit.dart';
import '../manager/search_event.dart';
import '../manager/search_state.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final TextEditingController _searchController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      body: Padding(
        padding: MyResponsive.paddingAll(context, value: 10),
        child: Column(
          children: [
            SizedBox(
              height: MyResponsive.height(context, value: 50),
            ),

            SearchBar(
              controller: _searchController,

              onChanged: (value) {
                if (value.trim().isEmpty) {
                  cubit.clearSearch();
                  return;
                }

                cubit.getSearchEvent(
                  SearchProductEvent(
                    search: ProductQueryParams(search: value),
                  ),
                );
              },

              leading: const Icon(
                CupertinoIcons.search,
                color: AppColors.textHint,
              ),

              trailing: [
                IconButton(
                  onPressed: () {
                    _searchController.clear();
                    cubit.clearSearch();
                    FocusScope.of(context).unfocus();
                  },
                  icon: const Icon(
                    Icons.cancel,
                    color: AppColors.textHint,
                  ),
                ),
              ],

              hintText: local.search,

              onSubmitted: (_) {
                FocusScope.of(context).unfocus();
              },
            ),

            const SizedBox(height: 10),

            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state.isSearchProductLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state.searchProductErrorMessage != null) {
                    return Center(
                      child: Text(state.searchProductErrorMessage!),
                    );
                  }

                  if (state.searchProducts.isEmpty) {
                    final hasSearchText =
                        _searchController.text.trim().isNotEmpty;

                    return Center(
                      child: Text(
                        hasSearchText
                            ? local.noProductsFound
                            : local.searchForAnyProductYouWant,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.medium14(context).copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    );
                  }

                  return CustomGridView(
                    itemCount: state.searchProducts.length,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ProductCard(
                        product: state.searchProducts[index],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}