import 'package:flower_app/config/products/data/params/product_query_params.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/my_responsive.dart';
import '../../../../core/shared_widgets/custom_grid_view.dart';
import '../../../../core/shared_widgets/custom_tab_bar.dart';
import '../../../../core/shared_widgets/product_card.dart';
import '../../../../core/utils/app_colors.dart';
import '../manager/category_cubit.dart';
import '../manager/category_event.dart';
import '../manager/category_state.dart';
import '../widget/custom_header_category.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return const _CategoryView();
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
          categoryId: ProductQueryParams(
            categoryId: null,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MyResponsive.paddingSymmetric(
        context,
        horizontal: 15,
        vertical: 50,
      ),
      child: Column(
        children: [
          const CustomHeaderCategory(),

          SizedBox(height: MyResponsive.height(context, value: 10)),

          ///? Category
          BlocBuilder<CategoryCubit, CategoryState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.errorMessage != null) {
                return Center(child: Text(state.errorMessage!));
              }

              return CategoryTabBar(
                categories: state.categories,
                selectedIndex: selectedIndex,
                onTap: (index) {
                  setState(() {
                    selectedIndex = index;
                  });

                  /// ALL tab
                  if (index == 0) {
                    context.read<CategoryCubit>().doEvent(
                      ProductEvent(
                        categoryId: ProductQueryParams(categoryId: null),
                      ),
                    );
                    return;
                  }

                  context.read<CategoryCubit>().doEvent(
                    ProductEvent(
                      categoryId: ProductQueryParams(
                        categoryId: state.categories[index].id!,
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
                  return const CircularProgressIndicator(
                    color: AppColors.primaryColor,
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
              buildWhen: (previous, current) =>
                  current.products != previous.products,
            ),
          ),
        ],
      ),
    );
  }
}
