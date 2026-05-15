import 'package:flower_app/config/products/data/params/product_query_params.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/di/di.dart';
import '../../../../core/helpers/my_responsive.dart';
import '../../../../core/localization/l10n/app_localizations.dart';
import '../../../../core/shared_widgets/custom_grid_view.dart';
import '../../../../core/shared_widgets/custom_tab_bar.dart';
import '../../../../core/shared_widgets/product_card.dart';
import '../../../../core/utils/app_colors.dart';
import '../manager/category_cubit.dart';
import '../manager/category_event.dart';
import '../manager/category_state.dart';
import '../widget/custom_header_category.dart';

class CategoryScreen extends StatelessWidget {
  final int initialIndex;

  const CategoryScreen({
    super.key,
    this.initialIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CategoryCubit>()
        ..doEvent(GetAllCategoryEvent()),
      child: _CategoryView(
        initialIndex: initialIndex,
      ),
    );
  }
}

class _CategoryView extends StatefulWidget {
  final int initialIndex;

  const _CategoryView({
    required this.initialIndex,
  });

  @override
  State<_CategoryView> createState() =>
      _CategoryViewState();
}

class _CategoryViewState
    extends State<_CategoryView> {

  late int selectedIndex;

  bool isFirstLoad = true;

  @override
  void initState() {
    super.initState();

    selectedIndex = widget.initialIndex;
  }

  void _loadProducts(CategoryState state) {

    ///? ALL TAB
    if (selectedIndex == 0) {

      context.read<CategoryCubit>().doEvent(
        ProductEvent(
          categoryId: ProductQueryParams(
            categoryId: null,
          ),
        ),
      );

      return;
    }

    ///? CATEGORY TAB
    if (state.categories.isNotEmpty &&
        selectedIndex - 1 <
            state.categories.length) {

      final categoryId =
      state.categories[selectedIndex - 1].id!;

      context.read<CategoryCubit>().doEvent(
        ProductEvent(
          categoryId: ProductQueryParams(
            categoryId: categoryId,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    final local =
    AppLocalizations.of(context)!;

    return Padding(
      padding: MyResponsive.paddingSymmetric(
        context,
        horizontal: 15,
      ),

      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        mainAxisSize: MainAxisSize.min,

        mainAxisAlignment:
        MainAxisAlignment.start,

        children: [

          SizedBox(
            height: MyResponsive.height(
              context,
              value: 50,
            ),
          ),

          const CustomHeaderCategory(),

          SizedBox(
            height: MyResponsive.height(
              context,
              value: 10,
            ),
          ),

          ///? Category
          BlocBuilder<CategoryCubit, CategoryState>(
            builder: (context, state) {

              if (state.isLoading) {
                return const SizedBox(
                  height: 60,
                  child: Center(
                    child:
                    CircularProgressIndicator(),
                  ),
                );
              }

              if (state.errorMessage != null) {
                return Center(
                  child: Text(
                    state.errorMessage!,
                  ),
                );
              }

              ///? Safety reset
              if (state.categories.isNotEmpty &&
                  selectedIndex >=
                      state.categories.length + 1) {

                selectedIndex = 0;
              }

              ///? First Load
              if (isFirstLoad &&
                  state.categories.isNotEmpty) {

                isFirstLoad = false;

                WidgetsBinding.instance
                    .addPostFrameCallback((_) {

                  _loadProducts(state);
                });
              }

              return CategoryTabBar(
                categories: state.categories,

                selectedIndex: selectedIndex,

                onTap: (index) {

                  setState(() {
                    selectedIndex = index;
                  });

                  _loadProducts(state);
                },
              );
            },
          ),

          ///? Product
          Expanded(
            child:
            BlocBuilder<CategoryCubit,
                CategoryState>(
              builder: (context, state) {

                if (state.isProductLoading) {
                  return const Center(
                    child:
                    CircularProgressIndicator(
                      color:
                      AppColors.primaryColor,
                    ),
                  );
                }

                if (state.productErrorMessage !=
                    null) {

                  return Center(
                    child: Text(
                      state.productErrorMessage!,
                    ),
                  );
                }

                return CustomGridView(

                  itemCount:
                  state.products.length,

                  itemBuilder:
                      (context, index) {

                    final product =
                    state.products[index];

                    return ProductCard(
                      name: product.title,

                      image: product.imgCover,

                      price: product.price,

                      priceAfterDiscount:
                      product
                          .priceAfterDiscount,

                      discount:
                      product.discount,

                      onAddToCart: () {},
                    );
                  },
                );
              },
            ),
          ),

          SizedBox(
            height: MyResponsive.height(
              context,
              value: 10,
            ),
          ),
        ],
      ),
    );
  }
}