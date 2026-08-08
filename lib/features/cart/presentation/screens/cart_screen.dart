import 'package:flower_app/core/localization/l10n/app_localizations.dart';
import 'package:flower_app/core/shared_widgets/custom_error_widget.dart';
import 'package:flower_app/core/shared_widgets/custom_loading_indicator.dart';
import 'package:flower_app/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared_widgets/custom_button.dart';
import '../../../../core/utils/app_colors.dart';
import '../manager/cart_cubit.dart';
import '../manager/cart_event.dart';
import '../manager/cart_state.dart';
import '../widget/custom_cart_item.dart';
import '../widget/custom_total_price.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(local.cart),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: BlocBuilder<CartCubit, CartState>(
        buildWhen: (previous, current) {
          return previous.getCartItemsState != current.getCartItemsState;
        },
        builder: (context, state) {
          /// Loading
          if (state.getCartItemsState.isLoading) {
            return const CustomLoadingIndicator();
          }

          /// Error
          if (state.getCartItemsState.errorMessage != null) {
            return CustomErrorWidget(
              errorMessage: state.getCartItemsState.errorMessage!,
              haveTryAgain: true,
              onPressed: () {
                context.read<CartCubit>().doEvent(GetCartItemsEvent());
              },
            );
          }

          final cartData = state.getCartItemsState.data;
          final isEmpty = cartData == null || cartData.cartItems.isEmpty;

          /// Empty
          if (isEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<CartCubit>().doEvent(GetCartItemsEvent());
              },
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.shopping_cart_outlined,
                              color: AppColors.primaryColor,
                              size: 80,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Your cart is empty",
                              style: AppTextStyles.bold20(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }

          /// Success
          return Column(
            children: [
              /// Scrollable Content
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    context.read<CartCubit>().doEvent(GetCartItemsEvent());
                  },
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    itemCount: cartData.cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartData.cartItems[index];

                      return CustomCartItem(
                        key: ValueKey(cartItem.productEntity.id),
                        cartItem: cartItem,
                      );
                    },
                  ),
                ),
              ),

              /// Bottom Section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(color: AppColors.grayDark, width: 0.2),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTotalPrice(
                      subTotal: cartData.totalPriceAfterDiscount ?? 0,
                      deliveryFee: 10,
                    ),
                    const SizedBox(height: 30),
                    CustomButton(title: "Check out", onPressed: () {}),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
