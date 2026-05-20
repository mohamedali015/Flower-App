import 'package:flower_app/config/di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/helpers/my_responsive.dart';
import '../../../../core/localization/l10n/app_localizations.dart';
import '../../../home/presentation/widgets/location_bar.dart';
import '../../data/model/request/update_cart_request.dart';
import '../manager/cart_cubit.dart';
import '../manager/cart_event.dart';
import '../manager/cart_state.dart';
import '../widget/custom_cart_item.dart';
import '../widget/custom_header_cart.dart';

@injectable
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (context) => getIt<CartCubit>()..doEvent(GetAllCartEvent()),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              final cartData = state.getCart.data;

              if (state.getCart.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.getCart.errorMessage != null) {
                return Center(child: Text(state.getCart.errorMessage!));
              }

              return Column(
                children: [
                  /// Header
                  CustomHeaderCart(getCart: state.getCart),

                  SizedBox(height: MyResponsive.height(context, value: 7)),

                  /// Location
                  LocationBar(),

                  /// Cart Items
                  BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                      if (state.addToCartSuccess.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state.addToCartSuccess.errorMessage != null) {
                        return Center(
                          child: Text(state.addToCartSuccess.errorMessage!),
                        );
                      }
                      return Expanded(
                        child: ListView.builder(
                          itemCount: cartData?.cartItems.length ?? 0,
                          itemBuilder: (context, index) {
                            final cartItem = cartData!.cartItems[index];

                            return CustomCartItem(
                              cartItem: cartItem,

                              onIncrease: () {
                                context.read<CartCubit>().doEvent(
                                  UpdateCart(
                                    UpdateCartRequest(
                                      quantity: cartItem.quantity! + 1,
                                    ),
                                    cartItem.productEntity.id,
                                  ),
                                );
                              },
                              onDelete: () {
                                context.read<CartCubit>().doEvent(
                                  RemoveToCart(cartItem.productEntity.id),
                                );
                              },

                              onDecrease: () {
                                final qty = cartItem.quantity ?? 0;
                                if (qty <= 1) {
                                  context.read<CartCubit>().doEvent(
                                    RemoveToCart(cartItem.productEntity.id),
                                  );
                                  return;
                                }
                                context.read<CartCubit>().doEvent(
                                  UpdateCart(
                                    UpdateCartRequest(quantity: qty - 1),
                                    cartItem.productEntity.id,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
