import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/shared_widgets/custom_button.dart';
import '../../../home/presentation/widgets/location_bar.dart';
import '../../data/model/request/update_cart_request.dart';
import '../manager/cart_cubit.dart';
import '../manager/cart_event.dart';
import '../manager/cart_state.dart';
import '../widget/custom_cart_item.dart';
import '../widget/custom_header_cart.dart';
import '../widget/custom_total_price.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(

        onRefresh: () async {
          context.read<CartCubit>().doEvent(GetAllCartEvent());

          await Future.delayed(
            const Duration(milliseconds: 500),
          );
        },

        child: Padding(
          padding: const EdgeInsets.all(8),

          child: BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {

              if (state.getCart.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state.getCart.errorMessage != null) {
                return Center(
                  child: Text(state.getCart.errorMessage!),
                );
              }

              final cartData = state.getCart.data;

              final isEmpty = cartData == null || cartData.cartItems.isEmpty;

              if (isEmpty) {
                return ListView(
                  children: const [

                    SizedBox(height: 250),

                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 80,
                    ),

                    SizedBox(height: 10),

                    Center(
                      child: Text(
                        "Your cart is empty",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                );
              }


              return Column(
                children: [

                  CustomHeaderCart(
                    getCart: state.getCart,
                  ),

                  const SizedBox(height: 10),

                  const LocationBar(),

                  const SizedBox(height: 10),

                  Expanded(
                    child: ListView.builder(
                      physics:
                      const AlwaysScrollableScrollPhysics(),

                      itemCount:
                      cartData.cartItems.length,

                      itemBuilder: (context, index) {

                        final cartItem =
                        cartData.cartItems[index];

                        return CustomCartItem(
                          cartItem: cartItem,

                          //? Increase
                          onIncrease: () {
                            context
                                .read<CartCubit>()
                                .doEvent(
                              UpdateCart(
                                UpdateCartRequest(
                                  quantity:
                                  (cartItem.quantity ?? 0) + 1,
                                ),

                                cartItem.productEntity.id,
                              ),
                            );
                          },

                          //? Decrease
                          onDecrease: () {

                            final qty =
                                cartItem.quantity ?? 0;

                            if (qty <= 1) {

                              context
                                  .read<CartCubit>()
                                  .doEvent(
                                RemoveToCart(
                                  cartItem.productEntity.id,
                                ),
                              );

                              return;
                            }

                            context
                                .read<CartCubit>()
                                .doEvent(
                              UpdateCart(
                                UpdateCartRequest(
                                  quantity: qty - 1,
                                ),

                                cartItem.productEntity.id,
                              ),
                            );
                          },

                          //? Delete
                          onDelete: () {

                            context
                                .read<CartCubit>()
                                .doEvent(
                              RemoveToCart(
                                cartItem.productEntity.id,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  CustomTotalPrice(
                    subTotal:
                    cartData.totalPriceAfterDiscount ?? 0,

                    deliveryFee: 10,
                  ),

                  const SizedBox(height: 20),

                  CustomButton(
                    title: "Check out",

                    onPressed: () {},
                  ),

                  const SizedBox(height: 20),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}