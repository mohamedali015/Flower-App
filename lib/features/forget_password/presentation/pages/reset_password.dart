import 'package:flower_app/core/helpers/app_snack_bar.dart';
import 'package:flower_app/core/shared_widgets/custom_button.dart';
import 'package:flower_app/features/forget_password/presentation/manager/cubit/forget_password_cubit.dart';
import 'package:flower_app/features/forget_password/presentation/manager/event/forget_password_event.dart';
import 'package:flower_app/features/forget_password/presentation/manager/state/forget_password_state.dart';
import 'package:flower_app/features/forget_password/presentation/widgets/reset_password_fields_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/route_manager/routes.dart';
import '../../../../core/helpers/my_responsive.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/values/app_strings.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final FocusNode passwordFocus = FocusNode();
  final FocusNode confirmPasswordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    // final local = AppLocalizations.of(context)!;
    final cubit = context.read<ForgetPasswordCubit>();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        // cubit.doEvent(NavigateToResetCodeEventSetUp(isInResetCodeState: false));
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.loginRoute,
          (route) => false,
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.resetPassword),
          leading: IconButton(
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.loginRoute,
              (route) => false,
            ),
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
        ),
        body: Padding(
          padding: MyResponsive.paddingSymmetric(
            context,
            horizontal: AppConstants.paddingHorizontal,
          ),
          child: Column(
            children: [
              SizedBox(height: MyResponsive.height(context, value: 40)),
              Text(
                AppStrings.resetPassword,
                textAlign: TextAlign.center,
                style: AppTextStyles.medium18(context),
              ),
              SizedBox(height: MyResponsive.height(context, value: 16)),
              Text(
                AppStrings.passwordMustNotBeEmpty,
                textAlign: TextAlign.center,
                style: AppTextStyles.regular14(context),
              ),
              SizedBox(height: MyResponsive.height(context, value: 32)),
              BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
                listenWhen: (previous, current) =>
                    previous.resetPasswordState != current.resetPasswordState,
                buildWhen: (previous, current) =>
                    previous.resetPasswordState != current.resetPasswordState,
                listener: (context, state) {
                  if (state.resetPasswordState!.isSuccess) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.loginRoute,
                      (route) => false,
                    );
                  } else if (state.resetPasswordState!.errorMessage != null) {
                    AppSnackBar.error(
                      context,
                      state.resetPasswordState!.errorMessage!,
                    );
                  }
                },
                builder: (context, state) {
                  return Form(
                    key: formKey,
                    child: Column(
                      children: [
                        ResetPasswordFieldsWidget(
                          passwordController: passwordController,
                          confirmPasswordController: confirmPasswordController,
                          isLoading: state.resetPasswordState!.isLoading,
                          passwordFocus: passwordFocus,
                          confirmPasswordFocus: confirmPasswordFocus,
                        ),
                        SizedBox(
                          height: MyResponsive.height(context, value: 48),
                        ),
                        CustomButton(
                          title: AppStrings.confirm,
                          isLoading: state.resetPasswordState!.isLoading,
                          onPressed: () {
                            if (!formKey.currentState!.validate()) {
                              return;
                            }

                            cubit.doEvent(
                              ResetPasswordEvent(
                                newPassword: passwordController.text,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
