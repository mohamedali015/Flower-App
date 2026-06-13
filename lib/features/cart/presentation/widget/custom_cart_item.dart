import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/cart/data/model/request/update_cart_request.dart';
import '../../../../config/cart/domain/entities/cart_item_entity.dart';
import '../../../../config/cart/manager/cart_cubit.dart';
import '../../../../config/cart/manager/cart_event.dart';
import '../../../../config/cart/manager/cart_state.dart';
import '../../../../core/localization/l10n/app_localizations.dart';
import '../../../../core/shared_widgets/cached_network_image_wrapper.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

class CustomCartItem extends StatefulWidget {
  const CustomCartItem({super.key, required this.cartItem});

  final CartItemEntity cartItem;

  @override
  State<CustomCartItem> createState() => _CustomCartItemState();
}

class _CustomCartItemState extends State<CustomCartItem> {
  bool isUpdating = false;
  bool isDeleting = false;

  void _increase() {
    setState(() => isUpdating = true);

    final qty = widget.cartItem.quantity ?? 0;

    context.read<CartCubit>().doEvent(
      UpdateCartItemEvent(
        quantity: UpdateCartRequest(quantity: qty + 1),
        productId: widget.cartItem.productEntity.id,
      ),
    );
  }

  void _decrease() {
    setState(() => isUpdating = true);

    final qty = widget.cartItem.quantity ?? 0;

    if (qty <= 1) {
      setState(() {
        isDeleting = true;
        isUpdating = false;
      });

      context.read<CartCubit>().doEvent(
        DeleteCartItemEvent(
          productId: widget.cartItem.productEntity.id,
        ),
      );

      return;
    }

    context.read<CartCubit>().doEvent(
      UpdateCartItemEvent(
        quantity: UpdateCartRequest(quantity: qty - 1),
        productId: widget.cartItem.productEntity.id,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return BlocListener<CartCubit, CartState>(
      listenWhen: (previous, current) =>
      previous.updateCartItemState != current.updateCartItemState ||
          previous.deleteCartItemState != current.deleteCartItemState,
      listener: (context, state) {
        if (!state.updateCartItemState.isLoading &&
            !state.deleteCartItemState.isLoading) {
          if (mounted) {
            setState(() {
              isUpdating = false;
              isDeleting = false;
            });
          }
        }
      },
      child: Container(
        height: 170,
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.grayDark),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Opacity(
              opacity: (isDeleting || isUpdating) ? 0.4 : 1.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// IMAGE
                  SizedBox(
                    width: 90,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImageWrapper(
                        imagePath: widget.cartItem.productEntity.imgCover,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  /// CONTENT
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        /// TITLE + DELETE
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.cartItem.productEntity.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.medium16(context).copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),

                            SizedBox(
                              width: 40,
                              height: 40,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  setState(() => isDeleting = true);

                                  context.read<CartCubit>().doEvent(
                                    DeleteCartItemEvent(
                                      productId: widget
                                          .cartItem
                                          .productEntity
                                          .id,
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  CupertinoIcons.delete,
                                  color: AppColors.error,
                                  size: 22,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 6),

                        /// DESCRIPTION
                        Text(
                          widget.cartItem.productEntity.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.regular13(context).copyWith(
                            color: AppColors.grayDark,
                          ),
                        ),

                        const SizedBox(height: 4),

                        /// PRICE + QUANTITY
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${local.egp} ${widget.cartItem.productEntity.priceAfterDiscount}",
                                style: AppTextStyles.semiBold16(context)
                                    .copyWith(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),

                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: _decrease,
                                  icon: const Icon(Icons.remove, size: 18),
                                ),
                                Text(
                                  widget.cartItem.quantity.toString(),
                                  style: AppTextStyles.semiBold14(context),
                                ),
                                IconButton(
                                  onPressed: _increase,
                                  icon: const Icon(Icons.add, size: 18),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /// LOADING
            if (isDeleting || isUpdating)
              const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}