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
    final categories = state.categoriesState.data ?? [];
    if (categories.isNotEmpty && selectedIndex - 1 < categories.length) {
      final categoryId = categories[selectedIndex - 1].id!;

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

          BlocSelector<CategoryCubit, CategoryState, String>(
            selector: (state) => state.selectedCategoryId ?? '',
            builder: (context, selectedCategoryId) {
              return CustomHeaderCategory(
                currentCategoryId: selectedCategoryId,
              );
            },
          ),

          SizedBox(height: MyResponsive.height(context, value: 10)),

          Expanded(
            child: BlocConsumer<CategoryCubit, CategoryState>(
              listener: (context, state) {
                final categories = state.categoriesState.data ?? [];

                /// SAFETY RESET
                if (categories.isNotEmpty &&
                    selectedIndex >= categories.length + 1) {
                  selectedIndex = 0;
                }

                /// FIRST LOAD
                if (isFirstLoad && categories.isNotEmpty) {
                  isFirstLoad = false;

                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _loadProducts(state);
                  });
                }
              },
              builder: (context, state) {
                /// CATEGORY LOADING
                if (state.categoriesState.isLoading) {
                  return const TabsShimmer();
                }

                /// CATEGORY ERROR
                if (state.categoriesState.errorMessage != null) {
                  return CustomErrorWidget(
                    errorMessage: state.categoriesState.errorMessage!,
                    haveTryAgain: true,
                    onPressed: () {
                      context.read<CategoryCubit>().doEvent(
                        GetAllCategoryEvent(),
                      );
                    },
                  );
                }

                final categories = state.categoriesState.data ?? [];
                final products = state.productsState.data ?? [];

                /// EMPTY CATEGORY
                if (categories.isEmpty) {
                  return CustomErrorWidget(
                    errorMessage: local.noCategoriesFound,
                  );
                }

                return Column(
                  children: [
                    /// TABS
                    CategoryTabBar(
                      categories: categories,
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
                          if (state.productsState.isLoading) {
                            return const GridProductShimmer();
                          }

                          /// PRODUCTS ERROR
                          if (state.productsState.errorMessage != null) {
                            return CustomErrorWidget(
                              errorMessage: state.productsState.errorMessage!,
                              haveTryAgain: true,
                              onPressed: () {
                                _loadProducts(state);
                              },
                            );
                          }

                          /// EMPTY PRODUCTS
                          if (products.isEmpty) {
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
                              itemCount: products.length,
                              itemBuilder: (context, index) {
                                final product = products[index];
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
