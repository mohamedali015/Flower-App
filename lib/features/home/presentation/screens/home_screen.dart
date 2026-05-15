import 'package:flower_app/config/route_manager/routes.dart';
import 'package:flower_app/core/helpers/my_responsive.dart';
import 'package:flower_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/di/di.dart';
import '../../../../core/shared_widgets/custom_bottom_nav.dart';
import '../../../category/presentation/manager/category_cubit.dart';
import '../../../category/presentation/manager/category_event.dart';
import '../../../category/presentation/manager/category_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) =>
      getIt<CategoryCubit>()
        ..doEvent(
          GetAllCategoryEvent(),
        ),

      child: Padding(
        padding: MyResponsive.paddingAll(
          context,
          value: 8,
        ),

        child: Column(
          children: [

            const SizedBox(
              height: 100,
            ),

            BlocBuilder<
                CategoryCubit,
                CategoryState>(
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

                return SizedBox(
                  height: 60,

                  child: ListView.builder(
                    scrollDirection:
                    Axis.horizontal,

                    itemCount:
                    state.categories.length,

                    itemBuilder:
                        (context, index) {

                      return GestureDetector(

                        onTap: () {

                          Navigator.pushReplacement(
                            context,

                            MaterialPageRoute(
                              builder: (_) =>
                                  CustomBottomNavBar(

                                    /// categories tab
                                    initialIndex: 1,

                                    /// selected category
                                    categoryIndex: index + 1,
                                  ),
                            ),
                          );
                        },

                        child: Padding(
                          padding:
                          const EdgeInsets
                              .symmetric(
                            horizontal: 12,
                          ),

                          child: Container(
                            padding:
                            const EdgeInsets
                                .symmetric(
                              horizontal: 20,
                            ),

                            alignment:
                            Alignment.center,

                            decoration:
                            BoxDecoration(
                              color: AppColors
                                  .primaryColor,

                              borderRadius:
                              BorderRadius.circular(
                                MyResponsive.radius(
                                  context,
                                  value: 15,
                                ),
                              ),
                            ),

                            child: Text(
                              state
                                  .categories[
                              index]
                                  .name ??
                                  '',

                              style: TextStyle(
                                color: AppColors
                                    .white,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}