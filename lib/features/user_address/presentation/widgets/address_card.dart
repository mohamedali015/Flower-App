import 'package:flower_app/config/di/di.dart';
import 'package:flower_app/config/route_manager/routes.dart';
import 'package:flower_app/core/helpers/my_responsive.dart';
import 'package:flower_app/core/shared_widgets/svg_wrapper.dart';
import 'package:flower_app/core/utils/app_assets.dart';
import 'package:flower_app/core/utils/app_colors.dart';
import 'package:flower_app/core/utils/app_text_styles.dart';
import 'package:flower_app/features/profile/presentation/widgets/icon_text_widget.dart';
import 'package:flower_app/features/user_address/domain/entities/address.dart';
import 'package:flower_app/features/user_address/presentation/manger/user_address_cubit.dart';
import 'package:flower_app/features/user_address/presentation/manger/user_address_events.dart';
import 'package:flower_app/features/user_address/presentation/manger/user_address_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/l10n/app_localizations.dart';
import '../../../../core/shared_widgets/custom_button.dart';

class AddressCard extends StatelessWidget {
  AddressCard(this.address, {super.key});

  Address address;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF9F9F9),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF535353).withOpacity(0.25),
                offset: Offset.zero,
                blurRadius: 4,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: IconTextWidget(
                      text: address.city ?? "",
                      iconPath: AppAssets.location,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      MyResponsive.radius(context, value: 10),
                                    ),
                                  ),
                                  backgroundColor: AppColors.background,
                                  child: Padding(
                                    padding: MyResponsive.paddingSymmetric(
                                      context,
                                      horizontal: 28,
                                      vertical: 32,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          local.logout.toUpperCase(),
                                          style: AppTextStyles.semiBold18(
                                            context,
                                          ),
                                        ),
                                        SizedBox(
                                          height: MyResponsive.height(
                                            context,
                                            value: 8,
                                          ),
                                        ),
                                        Text(
                                          local.confirm_delete,
                                          style: AppTextStyles.regular16(
                                            context,
                                          ).copyWith(color: AppColors.darkBase),
                                        ),
                                        SizedBox(
                                          height: MyResponsive.height(
                                            context,
                                            value: 24,
                                          ),
                                        ),

                                        Row(
                                          children: [
                                            Expanded(
                                              child: CustomButton(
                                                title: local.cancle,
                                                borderColor: AppColors.grayDark,
                                                titleStyle:
                                                    AppTextStyles.medium14(
                                                      context,
                                                    ).copyWith(
                                                      color: AppColors.darkBase,
                                                    ),
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                backgroundColor:
                                                    AppColors.background,
                                              ),
                                            ),

                                            SizedBox(
                                              width: MyResponsive.width(
                                                context,
                                                value: 12,
                                              ),
                                            ),
                                            Expanded(
                                              child: BlocProvider<UserAddressCubit>.value(
                                                value:
                                                    getIt<UserAddressCubit>(),
                                                child:
                                                    BlocBuilder<
                                                      UserAddressCubit,
                                                      UserAddressState
                                                    >(
                                                      builder: (context, state) {
                                                        final isLoading = state
                                                            .removeUserAddressState
                                                            .isLoading;

                                                        return CustomButton(
                                                          isLoading: isLoading,
                                                          title: local.delete,
                                                          backgroundColor:
                                                              AppColors
                                                                  .primaryColor,
                                                          titleStyle:
                                                              AppTextStyles.medium14(
                                                                context,
                                                              ).copyWith(
                                                                color: AppColors
                                                                    .baseWhite,
                                                              ),
                                                          onPressed: () {
                                                            context
                                                                .read<
                                                                  UserAddressCubit
                                                                >()
                                                                .doEvent(
                                                                  RemoveUserAddressEvent(
                                                                    address.id!,
                                                                  ),
                                                                );
                                                            Navigator.pop(
                                                              context,
                                                            );
                                                          },
                                                        );
                                                      },
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          icon: const SvgWrapper(path: AppAssets.bin),
                        ),
                        SizedBox(width: MyResponsive.width(context, value: 3)),
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              Routes.addAddressRoute,
                              arguments: address,
                            );
                          },
                          icon: const SvgWrapper(path: AppAssets.edit),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              address.placeMarks!.isNotEmpty
                  ? Text(
                      style: AppTextStyles.regular13(
                        context,
                      ).copyWith(color: AppColors.grayDark, fontSize: 12),
                      address.placeMarks?.first.subAdministrativeArea ?? "",
                    )
                  : const SizedBox(),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
