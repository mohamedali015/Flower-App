import 'package:flower_app/config/products/data/params/product_query_params.dart';
import 'package:flower_app/core/helpers/my_responsive.dart';
import 'package:flower_app/core/localization/l10n/app_localizations.dart';
import 'package:flower_app/core/shared_widgets/custom_grid_view.dart';
import 'package:flower_app/core/shared_widgets/product_card.dart';
import 'package:flower_app/core/utils/app_colors.dart';
import 'package:flower_app/core/utils/app_text_styles.dart';
import 'package:flower_app/features/search/presentation/manager/search_cubit.dart';
import 'package:flower_app/features/search/presentation/manager/search_event.dart';
import 'package:flower_app/features/search/presentation/manager/search_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
              hintText: local.search,

              leading: const Icon(
                CupertinoIcons.search,
                color: AppColors.textHint,
              ),

              trailing: [
                if (_searchController.text.isNotEmpty)
                  IconButton(
                    onPressed: () {
                      _searchController.clear();
                      cubit.clearSearch();

                      setState(() {});

                      FocusScope.of(context).unfocus();
                    },
                    icon: const Icon(
                      Icons.cancel,
                      color: AppColors.textHint,
                    ),
                  ),
              ],

              onChanged: (value) {
                setState(() {});

                if (value.trim().isEmpty) {
                  cubit.clearSearch();
                  return;
                }

                cubit.getSearchEvent(
                  SearchProductEvent(
                    search: ProductQueryParams(
                      search: value.trim(),
                    ),
                  ),
                );
              },

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
                      child: Text(
                        state.searchProductErrorMessage!,
                      ),
                    );
                  }

                  final hasSearchText =
                      _searchController.text.trim().isNotEmpty;

                  if (!hasSearchText) {
                    return Center(
                      child: Text(
                        local.searchForAnyProductYouWant,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.medium14(context).copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    );
                  }

                  if (state.searchProducts.isEmpty) {
                    return Center(
                      child: Text(
                        local.noProductsFound,
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