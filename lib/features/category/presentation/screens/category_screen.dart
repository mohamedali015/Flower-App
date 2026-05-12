import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/di/di.dart';
import '../../../../core/cubit/tab/tab_cubit.dart';
import '../../../../core/helpers/my_responsive.dart';
import '../../../../core/shared_widgets/custom_tab_bar.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TabCubit()),
        BlocProvider(
          create: (_) => getIt<CategoryCubit>()..doEvent(GetAllCategoryEvent()),
        ),
      ],
      child: const _CategoryView(),
    );
  }
}

class _CategoryView extends StatelessWidget {
  const _CategoryView();

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
          SizedBox(height: MyResponsive.height(context, value: 10),),
          Expanded(
            child: BlocBuilder<CategoryCubit, CategoryState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.errorMessage != null) {
                  return Center(child: Text(state.errorMessage!));
                }

                if (state.categories.isEmpty) {
                  return const Center(child: Text("No Categories Found"));
                }

                return BlocBuilder<TabCubit, int>(
                  builder: (context, selectedIndex) {
                    return CategoryTabBar(

                      categories: state.categories,
                      selectedIndex: selectedIndex,
                      onTap: (index) {
                        context.read<TabCubit>().changeTab(index);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
