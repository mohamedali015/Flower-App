import 'package:flower_app/core/localization/l10n/app_localizations.dart';
import 'package:flower_app/core/shared_widgets/custom_error_widget.dart';
import 'package:flower_app/core/shared_widgets/custom_loading_indicator.dart';
import 'package:flower_app/core/shared_widgets/product_card.dart';
import 'package:flower_app/core/utils/app_colors.dart';
import 'package:flower_app/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared_widgets/custom_grid_view.dart';
import '../../../../core/utils/app_constants.dart';
import '../manager/occasions_cubit.dart';
import '../manager/occasions_events.dart';
import '../manager/occasions_state.dart';
import '../widgets/occasion_taps_widget.dart';

class OccasionScreen extends StatefulWidget {
  const OccasionScreen({super.key, this.currentIndex});

  final int? currentIndex;

  @override
  State<OccasionScreen> createState() => _OccasionScreenState();
}

class _OccasionScreenState extends State<OccasionScreen> {
  bool isFirstProductsLoaded = false;

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OccasionsCubit>();

    final local = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },

          icon: const Icon(Icons.arrow_back_ios_new),
        ),

        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(local.occasion),
            Text(
              local.occasionSubTitle,

              style: AppTextStyles.medium13(
                context,
              ).copyWith(color: AppColors.grayDark),
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingHorizontal,
        ),

        child: BlocConsumer<OccasionsCubit, OccasionsState>(
          listener: (context, state) {
            final occasions = state.occasionsCategoryState.data;

            if (!isFirstProductsLoaded &&
                occasions != null &&
                occasions.isNotEmpty) {
              isFirstProductsLoaded = true;

              selectedIndex = widget.currentIndex ?? 0;

              cubit.doEvent(
                GetOccasionProductsEvent(
                  occasionId: occasions[selectedIndex].id,
                ),
              );
            }
          },
          builder: (context, state) {
            final occasions = state.occasionsCategoryState.data;

            if (state.occasionsCategoryState.isLoading) {
              return const CustomLoadingIndicator();
            } else if (state.occasionsCategoryState.errorMessage != null &&
                state.occasionsCategoryState.errorMessage!.isNotEmpty) {
              return CustomErrorWidget(
                errorMessage: state.occasionsCategoryState.errorMessage!,

                haveTryAgain: true,

                onPressed: () {
                  cubit.doEvent(GetOccasionsCategoriesEvent());
                },
              );
            } else if (occasions == null || occasions.isEmpty) {
              return CustomErrorWidget(errorMessage: local.noOccasionsFound);
            }

            final productsState = state.occasionProductsState;

            final products = productsState.data?.products;

            return Column(
              children: [
                const SizedBox(height: 16),
                OccasionTabsWidget(
                  occasions: occasions,
                  initialIndex: widget.currentIndex ?? 0,

                  onTap: (index) {
                    setState(() {
                      selectedIndex = index;
                    });

                    cubit.doEvent(
                      GetOccasionProductsEvent(
                        occasionId: occasions[index].id,
                      ),
                    );
                  },
                ),

                const SizedBox(height: 16),

                Expanded(
                  child: Builder(
                    builder: (_) {
                      if (productsState.isLoading) {
                        return const CustomLoadingIndicator();
                      } else if (productsState.errorMessage != null &&
                          productsState.errorMessage!.isNotEmpty) {
                        return CustomErrorWidget(
                          errorMessage: productsState.errorMessage!,
                          haveTryAgain: true,
                          onPressed: () {
                            cubit.doEvent(
                              GetOccasionProductsEvent(
                                occasionId: occasions[selectedIndex].id,
                              ),
                            );
                          },
                        );
                      } else if (products == null || products.isEmpty) {
                        return CustomErrorWidget(
                          errorMessage: local.noProductsFound,
                        );
                      }

                      return RefreshIndicator(
                        onRefresh: () async {
                          cubit.doEvent(
                            GetOccasionProductsEvent(
                              occasionId: occasions[selectedIndex].id,
                            ),
                          );
                        },

                        child: CustomGridView(
                          physics: const AlwaysScrollableScrollPhysics(),

                          childAspectRatio: 163 / 229,

                          itemCount: products.length,

                          padding: const EdgeInsets.only(bottom: 16),

                          itemBuilder: (context, index) {
                            return ProductCard(product: products[index]);
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
    );
  }
}
