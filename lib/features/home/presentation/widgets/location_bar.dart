import 'package:flower_app/config/di/di.dart';
import 'package:flower_app/config/route_manager/routes.dart';
import 'package:flower_app/core/helpers/app_snack_bar.dart';
import 'package:flower_app/core/helpers/my_responsive.dart';
import 'package:flower_app/core/localization/l10n/app_localizations.dart';
import 'package:flower_app/core/shared_widgets/svg_wrapper.dart';
import 'package:flower_app/core/utils/app_assets.dart';
import 'package:flower_app/core/utils/app_colors.dart';
import 'package:flower_app/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../user_address/domain/entities/address.dart';
import '../../../profile/presentation/widgets/location_bar_shimmer.dart';
import '../../../user_address/presentation/manger/user_address_cubit.dart';
import '../../../user_address/presentation/manger/user_address_events.dart';
import '../../../user_address/presentation/manger/user_address_state.dart';

class LocationBar extends StatelessWidget {
  final UserAddressCubit userAddressCubit = getIt<UserAddressCubit>()
    ..doEvent( GetLoggedUserAddressesEvent());

  LocationBar({super.key});

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    return BlocProvider<UserAddressCubit>.value(
      value: userAddressCubit,
      child: BlocConsumer<UserAddressCubit, UserAddressState>(
        buildWhen: (previous, current) =>
            previous.currentUserAddresses != current.currentUserAddresses ||
            previous.selectedAddress != current.selectedAddress,
        builder: (BuildContext context, state) {
          if (state.currentUserAddresses == null) {
            return const LocationBarShimmer();
          } else if (state.currentUserAddresses != null &&
              state.currentUserAddresses!.isNotEmpty) {
            final selectedAddress =
                state.selectedAddress ?? state.currentUserAddresses!.last;
            return InkWell(
              onTap: () => _showAddressBottomSheet(context, state),
              child: Padding(
                padding: MyResponsive.paddingSymmetric(context, vertical: 17),
                child: Row(
                  children: [
                    SvgWrapper(
                      path: AppAssets.location,
                      width: MyResponsive.width(context, value: 20),
                      height: MyResponsive.height(context, value: 20),
                    ),
                    SizedBox(width: MyResponsive.width(context, value: 5)),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "${local.deliverTo} ",
                            style: AppTextStyles.medium14(
                              context,
                            ).copyWith(color: AppColors.grayDark),
                          ),
                          TextSpan(
                            text:
                                selectedAddress.placeMarks?.firstOrNull
                                    ?.subAdministrativeArea ??
                                "",
                            style: AppTextStyles.medium14(
                              context,
                            ).copyWith(color: AppColors.black100),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: MyResponsive.width(context, value: 8)),
                    SvgWrapper(
                      path: AppAssets.pinkArrow,
                      width: MyResponsive.width(context, value: 16),
                      height: MyResponsive.height(context, value: 16),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return TextButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.savedAddressesRoute);
              },
              child: Text(
                local.add_address,
                style: AppTextStyles.medium14(context).copyWith(
                  color: AppColors.primaryColor,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.primaryColor,
                ),
              ),
            );
          }
        },
        listenWhen: (previous, current) =>
            previous.currentUserAddresses != current.currentUserAddresses,
        listener: (BuildContext context, state) {
          if (state.getLoggedUserAddressesState.isLoading == false &&
              state.getLoggedUserAddressesState.isSuccess == false) {
            AppSnackBar.error(
              context,
              state.getLoggedUserAddressesState.errorMessage!,
            );
          }
        },
      ),
    );
  }

  void _showAddressBottomSheet(BuildContext context, UserAddressState state) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: MyResponsive.paddingAll(context, value: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.saved_address,
                style: AppTextStyles.semiBold18(context),
              ),
              SizedBox(height: MyResponsive.height(context, value: 16)),
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: state.currentUserAddresses!.length,
                  separatorBuilder:
                      (context, index) =>
                          SizedBox(height: MyResponsive.height(context, value: 10)),
                  itemBuilder: (context, index) {
                    final address = state.currentUserAddresses![index];
                    final isSelected =
                        (state.selectedAddress?.id ??
                            state.currentUserAddresses!.last.id) ==
                        address.id;
                    return InkWell(
                      onTap: () {
                        userAddressCubit.doEvent(
                          SetSelectedAddressEvent(address),
                        );
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: MyResponsive.paddingAll(context, value: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color:
                                isSelected
                                    ? AppColors.primaryColor
                                    : AppColors.grayDark.withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          children: [
                            const SvgWrapper(path: AppAssets.location),
                            SizedBox(width: MyResponsive.width(context, value: 10)),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    address.city ?? "",
                                    style: AppTextStyles.medium14(context),
                                  ),
                                  Text(
                                    address.placeMarks?.firstOrNull
                                            ?.subAdministrativeArea ??
                                        "",
                                    style: AppTextStyles.regular13(
                                      context,
                                    ).copyWith(color: AppColors.grayDark),
                                  ),
                                ],
                              ),
                            ),
                            if (isSelected)
                              const Icon(
                                Icons.check_circle,
                                color: AppColors.primaryColor,
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
