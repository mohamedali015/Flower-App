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

import '../../../profile/presentation/widgets/location_bar_shimmer.dart';
import '../../../user_address/presentation/manger/user_address_cubit.dart';
import '../../../user_address/presentation/manger/user_address_events.dart';
import '../../../user_address/presentation/manger/user_address_state.dart';

class LocationBar extends StatelessWidget {
  final UserAddressCubit userAddressCubit = getIt<UserAddressCubit>()
    ..doEvent(GetLoggedUserAddressEvent());

  LocationBar({super.key});

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    return BlocProvider<UserAddressCubit>.value(
      value: userAddressCubit,
      child: BlocConsumer<UserAddressCubit, UserAddressState>(
        buildWhen: (previous, current) =>
            previous.currentUserAddress != current.currentUserAddress,
        builder: (BuildContext context, state) {
          if (state.currentUserAddress == null) {
            return const LocationBarShimmer();
          } else if (state.currentUserAddress != null &&
              state.currentUserAddress!.isNotEmpty) {
            return Padding(
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
                          text: state.currentUserAddress!.last.placeMarks
                                  ?.firstOrNull?.subAdministrativeArea ??
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
            previous.currentUserAddress != current.currentUserAddress,
        listener: (BuildContext context, state) {
          if (state.getLoggedUserAddressState.isLoading == false &&
              state.getLoggedUserAddressState.isSuccess == false) {
            AppSnackBar.error(
              context,
              state.getLoggedUserAddressState.errorMessage!,
            );
          }
        },
      ),
    );
  }
}
