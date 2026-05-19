import 'package:flower_app/config/di/di.dart';
import 'package:flower_app/config/route_manager/routes.dart';
import 'package:flower_app/core/helpers/my_responsive.dart';
import 'package:flower_app/core/localization/l10n/app_localizations.dart';
import 'package:flower_app/core/shared_widgets/custom_button.dart';
import 'package:flower_app/core/utils/app_colors.dart';
import 'package:flower_app/core/utils/app_text_styles.dart';
import 'package:flower_app/features/logout/presentation/manager/cubit/logout_cubit.dart';
import 'package:flower_app/features/logout/presentation/manager/cubit/logout_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (_) => getIt<LogoutCubit>(),
      child: BlocListener<LogoutCubit, LogoutState>(
        listener: (context, state) {
          if (state is LogoutSuccess) {
            Navigator.pop(context);
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.loginRoute,
              (route) => false,
            );
          } else if (state is LogoutFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
          }
        },
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              MyResponsive.radius(context, value: 10),
            ),
          ),
          backgroundColor: AppColors.background,
          child: Padding(
            padding: MyResponsive.paddingSymmetric(
              context,
              horizontal: 32,
              vertical: 32,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  local.logout.toUpperCase(),
                  style: AppTextStyles.semiBold18(context),
                ),
                SizedBox(height: MyResponsive.height(context, value: 8)),
                Text(
                  local.confirmLogout,
                  style: AppTextStyles.regular16(
                    context,
                  ).copyWith(color: AppColors.darkBase),
                ),
                SizedBox(height: MyResponsive.height(context, value: 24)),

                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        title: local.cancle,
                        borderColor: AppColors.grayDark,
                        titleStyle: AppTextStyles.medium14(
                          context,
                        ).copyWith(color: AppColors.darkBase),
                        onPressed: () => Navigator.pop(context),
                        backgroundColor: AppColors.background,
                      ),
                    ),

                    SizedBox(width: MyResponsive.width(context, value: 16)),

                    Expanded(
                      child: BlocBuilder<LogoutCubit, LogoutState>(
                        builder: (context, state) {
                          final isLoading = state is LogoutLoading;

                          return CustomButton(
                            isLoading: isLoading,
                            title: local.logout,
                            backgroundColor: AppColors.primaryColor,
                            titleStyle: AppTextStyles.medium14(
                              context,
                            ).copyWith(color: AppColors.baseWhite),
                            onPressed: () {
                              context.read<LogoutCubit>().doEvents(
                                LogoutEvent(),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
