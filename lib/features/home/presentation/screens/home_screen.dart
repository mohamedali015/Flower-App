import 'package:flower_app/config/route_manager/routes.dart';
import 'package:flower_app/core/helpers/my_responsive.dart';
import 'package:flower_app/core/localization/l10n/app_localizations.dart';
import 'package:flower_app/core/shared_widgets/custom_error_widget.dart';
import 'package:flower_app/features/home/presentation/manager/cubit/home_cubit.dart';
import 'package:flower_app/features/home/presentation/manager/cubit/home_events.dart';
import 'package:flower_app/features/home/presentation/manager/cubit/home_state.dart';
import 'package:flower_app/features/home/presentation/widgets/best_seller/best_seller_list.dart';
import 'package:flower_app/features/home/presentation/widgets/categories/categories_list.dart';
import 'package:flower_app/features/home/presentation/widgets/headline_widget.dart';
import 'package:flower_app/features/home/presentation/widgets/location_bar.dart';
import 'package:flower_app/features/home/presentation/widgets/logo_and_searchBar.dart';
import 'package:flower_app/features/home/presentation/widgets/occasions/occasions_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/home_shimmer_loading.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: MyResponsive.paddingSymmetric(
            context,
            horizontal: 16,
            vertical: 16,
          ),
          child: Column(
            children: [
              LogoAndSearchBar(local: local),
              LocationBar(local: local),

              Expanded(
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoading) {
                      return const HomeShimmerLoading();
                    } else if (state is HomeFailure) {
                      return CustomErrorWidget(
                        errorMessage: state.errorMessage,
                      );
                    } else if (state is HomeSuccess) {
                      final home = state.homeResponseEntity;

                      return RefreshIndicator(
                        onRefresh: () async {
                          context.read<HomeCubit>().doEvents(GetHomeEvent());
                        },
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              /// Categories
                              HeadlineWidget(
                                local: local,
                                title: local.categories,
                                onViewAllPressed: () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    Routes.bottomNavBarRoute,
                                    arguments: {
                                      "initialIndex": 1,
                                      "categoryIndex": 0,
                                    },
                                  );
                                },
                              ),
                              CategoriesList(
                                categories: home.categories,

                                onPressed: (index) {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    Routes.bottomNavBarRoute,

                                    arguments: {
                                      "initialIndex": 1,
                                      "categoryIndex": index + 1,
                                    },
                                  );
                                },
                              ),

                              /// Best Seller
                              HeadlineWidget(
                                local: local,

                                title: local.bestSeller,
                                onViewAllPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    Routes.bestSellerRoute,
                                  );
                                },
                              ),
                              BestSellerList(items: home.bestSeller),

                              /// Occasions
                              HeadlineWidget(
                                local: local,

                                title: local.occasion,
                                onViewAllPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    Routes.occasionRoute,
                                  );
                                },
                              ),
                              OccasionsList(items: home.occasions),
                            ],
                          ),
                        ),
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
