import 'package:flower_app/core/shared_widgets/custom_error_widget.dart';
import 'package:flower_app/core/shared_widgets/custom_grid_view.dart';
import 'package:flower_app/core/shared_widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/l10n/app_localizations.dart';
import '../../../../core/shared_widgets/shimmer/grid_product_shimmer.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../manager/best_seller_cubit.dart';
import '../manager/best_seller_event.dart';
import '../manager/best_seller_state.dart';

class BestSellerScreen extends StatelessWidget {
  const BestSellerScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            Text(local.bestSeller),
            Text(
              local.bloomExquisiteMessage,

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
        child: BlocBuilder<BestSellerCubit, BestSellerState>(
          builder: (context, state) {
            final bestState = state.bestSellerState;

            // 1. حالة التحميل
            if (bestState.isLoading) {
              return const GridProductShimmer();
            }

            // 2. حالة الخطأ
            if (bestState.errorMessage != null) {
              return CustomErrorWidget(
                errorMessage: bestState.errorMessage ?? "",
                haveTryAgain: true,
                onPressed: () {
                  context.read<BestSellerCubit>().doEvent(GetBestSellerEvent());
                },
              );
            }

            // 3. حالة النجاح (لو القائمة فاضية)
            if (bestState.data == null || bestState.data!.products.isEmpty) {
              return CustomErrorWidget(errorMessage: local.noProductsFound);
            }

            // 4. عرض البيانات
            return CustomGridView(
              itemCount: bestState.data!.products.length,
              itemBuilder: (context, index) =>
                  ProductCard(product: bestState.data!.products[index]),
            );
          },
        ),
      ),
    );
  }
}
