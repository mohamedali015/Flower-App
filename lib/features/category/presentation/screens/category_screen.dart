import 'package:flower_app/config/products/data/params/product_query_params.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/di/di.dart';
import '../../../../core/helpers/my_responsive.dart';
import '../../../../core/localization/l10n/app_localizations.dart';
import '../../../../core/shared_widgets/custom_grid_view.dart';
import '../../../../core/shared_widgets/custom_tab_bar.dart';
import '../../../../core/shared_widgets/product_card.dart';
import '../../../../core/shared_widgets/svg_wrapper.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';

import '../../../../core/utils/app_text_styles.dart';
import '../manager/category_cubit.dart';
import '../manager/category_event.dart';
import '../manager/category_state.dart';
import '../widget/custom_header_category.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CategoryCubit>()
        ..doEvent(GetAllCategoryEvent()),
      child: const _CategoryView(),
    );
  }
}

class _CategoryView extends StatefulWidget {
  const _CategoryView();

  @override
  State<_CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<_CategoryView> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CategoryCubit>().doEvent(
        ProductEvent(
          categoryId: ProductQueryParams(categoryId: null),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Padding(
      padding: MyResponsive.paddingSymmetric(
        context,
        horizontal: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: MyResponsive.height(context, value: 50)),
          const CustomHeaderCategory(),

          SizedBox(height: MyResponsive.height(context, value: 10)),

          ///? Category
          BlocBuilder<CategoryCubit, CategoryState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const SizedBox(
                  height: 60,
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (state.errorMessage != null) {
                return Center(child: Text(state.errorMessage!));
              }

              ///? safety reset (optional stability fix)
              if (state.categories.isNotEmpty &&
                  selectedIndex >= state.categories.length + 1) {
                selectedIndex = 0;
              }

              return CategoryTabBar(
                categories: state.categories,
                selectedIndex: selectedIndex,
                onTap: (index) {
                  setState(() {
                    selectedIndex = index;
                  });

                  ///? ALL tab
                  if (index == 0) {
                    context.read<CategoryCubit>().doEvent(
                      ProductEvent(
                        categoryId: ProductQueryParams(categoryId: null),
                      ),
                    );
                    return;
                  }

                  ///? CATEGORY TAB
                  final categoryId = state.categories.isNotEmpty
                      ? state.categories[index - 1].id!
                      : null;

                  context.read<CategoryCubit>().doEvent(
                    ProductEvent(
                      categoryId: ProductQueryParams(
                        categoryId: categoryId,
                      ),
                    ),
                  );
                },
              );
            },
          ),

          ///? Product
          Expanded(
            child: BlocBuilder<CategoryCubit, CategoryState>(
              builder: (context, state) {
                if (state.isProductLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  );
                }

                if (state.productErrorMessage != null) {
                  return Center(child: Text(state.productErrorMessage!));
                }

                return CustomGridView(

                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    final product = state.products[index];

                    return ProductCard(
                      name: product.title,
                      image: product.imgCover,
                      price: product.price,
                      priceAfterDiscount: product.priceAfterDiscount,
                      discount: product.discount,
                      onAddToCart: () {},
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(height: MyResponsive.height(context, value: 10)),
          // Container(
          //   padding: MyResponsive.paddingSymmetric(
          //     context,
          //     horizontal: 15,
          //   ),
          //   decoration: BoxDecoration(
          //     color: AppColors.primaryColor,
          //     borderRadius: BorderRadius.circular(MyResponsive.radius(context, value: 15))
          //   ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       SvgWrapper(path: AppAssets.sortIcons,color: AppColors.white,),
          //       SizedBox(width: MyResponsive.width(context, value: 10)),
          //       Text(
          //         local.filter,
          //         style: AppTextStyles.medium18(context).copyWith(
          //             color: AppColors.white,
          //           fontWeight: FontWeight.bold
          //         ),
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}