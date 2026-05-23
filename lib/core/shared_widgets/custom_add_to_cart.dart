import 'package:flower_app/config/add_to_cart/presentation/manager/add_cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../config/add_to_cart/presentation/manager/add_cart_cubit.dart';
import '../../config/add_to_cart/presentation/manager/add_cart_event.dart';
import '../../config/di/di.dart';
import '../../features/cart/data/model/request/add_to_cart_request.dart';
import '../../features/cart/presentation/manager/cart_cubit.dart';
import '../../features/cart/presentation/manager/cart_event.dart';
import '../helpers/app_snack_bar.dart';
import '../localization/l10n/app_localizations.dart';
import '../utils/app_assets.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import 'svg_wrapper.dart';

class CustomAddToCart extends StatelessWidget {
  final String productId;
  final int quantity;
  final VoidCallback? onSuccess;

  const CustomAddToCart({
    super.key,
    required this.productId,
    this.quantity = 1,
    this.onSuccess,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (context) => getIt<AddCartCubit>(),
      child: BlocBuilder<AddCartCubit, AddCartState>(
        builder: (context, state) {
          if (state.addToCartSuccess.isSuccess) {
            Future.microtask(() {
              if (!context.mounted) return;
              context.read<CartCubit>().doEvent(GetCartItemsEvent());
              AppSnackBar.success(context, local.addedSuccessfully);
            });
          }

          if (state.addToCartSuccess.errorMessage != null) {
            Future.microtask(() {
              if (!context.mounted) return;
              AppSnackBar.error(context, state.addToCartSuccess.errorMessage!);
            });
          }
          return ElevatedButton(
            onPressed: state.addToCartSuccess.isLoading
                ? null
                : () {
                    context.read<AddCartCubit>().doEvent(
                      AddToCart(
                        AddToCartRequest(
                          product: productId,
                          quantity: quantity,
                        ),
                      ),
                    );

                    onSuccess?.call();
                  },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 30),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
              textStyle: AppTextStyles.medium13(context),
            ),

            child: state.addToCartSuccess.isLoading
                ? const SizedBox(
                    height: 15,
                    width: 15,
                    child: CircularProgressIndicator(
                      color: AppColors.baseWhite,
                      strokeWidth: 2,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SvgWrapper(
                        path: AppAssets.cartIcon,
                        color: AppColors.white,
                        width: 15,
                        height: 15,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        local.addToCart,
                        style: AppTextStyles.medium13(
                          context,
                        ).copyWith(color: AppColors.white),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
