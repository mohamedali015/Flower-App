import 'package:flower_app/config/products/data/params/product_query_params.dart';
import 'package:flower_app/core/helpers/my_responsive.dart';
import 'package:flower_app/core/localization/l10n/app_localizations.dart';
import 'package:flower_app/core/shared_widgets/custom_error_widget.dart';
import 'package:flower_app/core/shared_widgets/custom_grid_view.dart';
import 'package:flower_app/core/shared_widgets/custom_tab_bar.dart';
import 'package:flower_app/core/shared_widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/di/di.dart';
import '../../../../core/shared_widgets/shimmer/grid_product_shimmer.dart';
import '../../../../core/shared_widgets/shimmer/tabs_shimmer.dart';
import '../manager/category_cubit.dart';
import '../manager/category_event.dart';
import '../manager/category_state.dart';
import '../widget/custom_header_category.dart';

class CategoryScreen extends StatelessWidget {
  final int initialIndex;

  const CategoryScreen({super.key, this.initialIndex = 0});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CategoryCubit>()..doEvent(GetAllCategoryEvent()),
      child: _CategoryView(initialIndex: initialIndex),
    );
  }
}

class _CategoryView extends StatefulWidget {
  final int initialIndex;

  const _CategoryView({required this.initialIndex});

  @override
  State<_CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<_CategoryView> {
  late int selectedIndex;
  bool isFirstLoad = true;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
  }

  void _loadProducts(CategoryState state) {
    /// ALL TAB
    if (selectedIndex == 0) {
      context.read<CategoryCubit>().doEvent(
        ProductEvent(
          categoryId: ProductQueryParams(
            categoryId: null,
            sort: state.selectedSortOption,
          ),
        ),
      );
      return;
    }

    /// CATEGORY TAB
    if (state.categories.isNotEmpty &&
        selectedIndex - 1 < state.categories.length) {
      final categoryId = state.categories[selectedIndex - 1].id!;

      context.read<CategoryCubit>().doEvent(
        ProductEvent(
          categoryId: ProductQueryParams(
            categoryId: categoryId,
            sort: state.selectedSortOption,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Padding(
      padding: MyResponsive.paddingSymmetric(context, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MyResponsive.height(context, value: 50)),

          BlocBuilder<CategoryCubit, CategoryState>(
            buildWhen: (previous, current) =>
                previous.selectedCategoryId != current.selectedCategoryId,
            builder: (context, state) {
              return CustomHeaderCategory(
                currentCategoryId: state.selectedCategoryId ?? '',
              );
            },
          ),

          SizedBox(height: MyResponsive.height(context, value: 10)),

          Expanded(
            child: BlocConsumer<CategoryCubit, CategoryState>(
              listener: (context, state) {
                /// SAFETY RESET
                if (state.categories.isNotEmpty &&
                    selectedIndex >= state.categories.length + 1) {
                  selectedIndex = 0;
                }

                /// FIRST LOAD
                if (isFirstLoad && state.categories.isNotEmpty) {
                  isFirstLoad = false;

                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _loadProducts(state);
                  });
                }
              },
              builder: (context, state) {
                /// CATEGORY LOADING
                if (state.isLoading) {
                  return const TabsShimmer();
                }

                /// CATEGORY ERROR
                if (state.errorMessage != null) {
                  return CustomErrorWidget(
                    errorMessage: state.errorMessage!,
                    haveTryAgain: true,
                    onPressed: () {
                      context.read<CategoryCubit>().doEvent(
                        GetAllCategoryEvent(),
                      );
                    },
                  );
                }

                /// EMPTY CATEGORY
                if (state.categories.isEmpty) {
                  return CustomErrorWidget(
                    errorMessage: local.noCategoriesFound,
                  );
                }

                return Column(
                  children: [
                    /// TABS
                    CategoryTabBar(
                      categories: state.categories,
                      selectedIndex: selectedIndex,
                      onTap: (index) {
                        if (selectedIndex == index) return;

                        setState(() {
                          selectedIndex = index;
                        });

                        _loadProducts(state);
                      },
                    ),

                    SizedBox(height: MyResponsive.height(context, value: 16)),

                    /// PRODUCTS
                    Expanded(
                      child: Builder(
                        builder: (_) {
                          /// PRODUCTS LOADING
                          if (state.isProductLoading) {
                            return const GridProductShimmer();
                          }

                          /// PRODUCTS ERROR
                          if (state.productErrorMessage != null) {
                            return CustomErrorWidget(
                              errorMessage: state.productErrorMessage!,
                              haveTryAgain: true,
                              onPressed: () {
                                _loadProducts(state);
                              },
                            );
                          }

                          /// EMPTY PRODUCTS
                          if (state.products.isEmpty) {
                            return CustomErrorWidget(
                              errorMessage: local.noProductsFound,
                            );
                          }

                          return RefreshIndicator(
                            onRefresh: () async {
                              _loadProducts(state);
                            },
                            child: CustomGridView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: state.products.length,
                              itemBuilder: (context, index) {
                                final product = state.products[index];
                                return ProductCard(product: product);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          SizedBox(height: MyResponsive.height(context, value: 10)),
        ],
      ),
    );
  }
}
