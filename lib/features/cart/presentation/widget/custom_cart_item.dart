import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/l10n/app_localizations.dart';
import '../../../../core/shared_widgets/cached_network_image_wrapper.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../data/model/request/update_cart_request.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../manager/cart_cubit.dart';
import '../manager/cart_event.dart';
import '../manager/cart_state.dart';

class CustomCartItem extends StatefulWidget {
  const CustomCartItem({super.key, required this.cartItem});

  final CartItemEntity cartItem;

  @override
  State<CustomCartItem> createState() => _CustomCartItemState();
}

class _CustomCartItemState extends State<CustomCartItem> {
  bool isUpdating = false;
  bool isDeleting = false;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.grayDark),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          /// Content with Opacity & IgnorePointer for deleting state
          Opacity(
            opacity: isDeleting ? 0.4 : 1.0,
            child: IgnorePointer(
              ignoring: isDeleting,
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    /// Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImageWrapper(
                        imagePath: widget.cartItem.productEntity.imgCover,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 10),

                    /// Content
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Column(
                          children: [
                            /// Top Section
                            ListTile(
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              minVerticalPadding: 0,
                              title: Text(
                                widget.cartItem.productEntity.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.medium16(
                                  context,
                                ).copyWith(fontWeight: FontWeight.w600),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  widget.cartItem.productEntity.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.regular13(
                                    context,
                                  ).copyWith(color: AppColors.grayDark),
                                ),
                              ),
                              trailing: BlocListener<CartCubit, CartState>(
                                listenWhen: (previous, current) {
                                  return previous.deleteCartItemState !=
                                      current.deleteCartItemState;
                                },
                                listener: (context, state) {
                                  if (!state.deleteCartItemState.isLoading) {
                                    if (mounted) {
                                      setState(() {
                                        isDeleting = false;
                                      });
                                    }
                                  }
                                },
                                child: SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      setState(() {
                                        isDeleting = true;
                                      });

                                      context.read<CartCubit>().doEvent(
                                        DeleteCartItemEvent(
                                          productId:
                                              widget.cartItem.productEntity.id,
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
                              ),
                            ),
                            const SizedBox(height: 20),

                            /// Bottom Section
                            Row(
                              children: [
                                /// Price
                                Expanded(
                                  child: Text(
                                    "${local.egp} ${widget.cartItem.productEntity.priceAfterDiscount}",
                                    style: AppTextStyles.semiBold16(
                                      context,
                                    ).copyWith(color: AppColors.primaryColor),
                                  ),
                                ),

                                /// Quantity Controls
                                isUpdating
                                    ? const SizedBox(
                                        width: 90,
                                        height: 40,
                                        child: Center(
                                          child: SizedBox(
                                            width: 24,
                                            height: 24,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2.5,
                                            ),
                                          ),
                                        ),
                                      )
                                    : Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          /// Minus
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                isUpdating = true;
                                              });

                                              final qty =
                                                  widget.cartItem.quantity ?? 0;

                                              if (qty <= 1) {
                                                setState(() {
                                                  isDeleting = true;
                                                  isUpdating = false;
                                                });

                                                context
                                                    .read<CartCubit>()
                                                    .doEvent(
                                                      DeleteCartItemEvent(
                                                        productId: widget
                                                            .cartItem
                                                            .productEntity
                                                            .id,
                                                      ),
                                                    );

                                                return;
                                              }

                                              context.read<CartCubit>().doEvent(
                                          UpdateCartItemEvent(
                                            quantity: UpdateCartRequest(
                                              quantity: qty - 1,
                                            ),
                                            productId: widget
                                                .cartItem
                                                .productEntity
                                                .id,
                                          ),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.remove,
                                        size: 18,
                                      ),
                                    ),

                                          /// Quantity
                                          Text(
                                            widget.cartItem.quantity.toString(),
                                            style: AppTextStyles.semiBold14(
                                              context,
                                            ),
                                          ),

                                          /// Plus
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isUpdating = true;
                                        });

                                        context.read<CartCubit>().doEvent(
                                          UpdateCartItemEvent(
                                            quantity: UpdateCartRequest(
                                              quantity:
                                              (widget
                                                  .cartItem
                                                  .quantity ??
                                                  0) +
                                                  1,
                                            ),
                                            productId: widget
                                                .cartItem
                                                .productEntity
                                                .id,
                                          ),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.add,
                                        size: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            /// Update Listener
                            BlocListener<CartCubit, CartState>(
                              listenWhen: (previous, current) {
                                return previous.updateCartItemState !=
                                    current.updateCartItemState;
                              },
                              listener: (context, state) {
                                if (!state.updateCartItemState.isLoading) {
                                  if (mounted) {
                                    setState(() {
                                      isUpdating = false;
                                    });
                                  }
                                }
                              },
                              child: const SizedBox.shrink(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          /// Delete Loading Indicator
          if (isDeleting) const CircularProgressIndicator(),
        ],
      ),
    );
  }
}
