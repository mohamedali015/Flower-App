import 'dart:async';

import 'package:flower_app/core/helpers/app_snack_bar.dart';
import 'package:flower_app/features/forget_password/presentation/manager/cubit/forget_password_cubit.dart';
import 'package:flower_app/features/forget_password/presentation/manager/state/forget_password_state.dart';
import 'package:flower_app/features/forget_password/presentation/widgets/custom_otp_field.dart';
import 'package:flower_app/features/forget_password/presentation/widgets/otp_resened_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../core/helpers/my_responsive.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/values/app_strings.dart';
import '../manager/event/forget_password_event.dart';

class VerifyCode extends StatelessWidget {
  VerifyCode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController();
  final StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>.broadcast();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgetPasswordCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.emailVerification),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Padding(
        padding: MyResponsive.paddingSymmetric(
          context,
          horizontal: AppConstants.paddingHorizontal,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: MyResponsive.height(context, value: 40)),
              Text(
                AppStrings.emailVerification,
                textAlign: TextAlign.center,
                style: AppTextStyles.medium18(context),
              ),
              SizedBox(height: MyResponsive.height(context, value: 16)),
              Text(
                AppStrings.enterYourCode,
                textAlign: TextAlign.center,
                style: AppTextStyles.regular14(context),
              ),
              SizedBox(height: MyResponsive.height(context, value: 16)),
              BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
                buildWhen: (previous, current) => false,
                builder: (context, state) {
                  return CustomOtpField(
                    onCompleted: (value) {
                      cubit.doEvent(
                        VerifyOtpEvent(
                          value,
                          otpController: otpController,
                          errorController: errorController,
                        ),
                      );
                    },
                    errorController: errorController,
                    controller: otpController,
                    isLoading: state.verifyOtpState!.isLoading,
                  );
                },
                listenWhen: (previous, current) {
                  return false;
                },

                listener: (BuildContext context, ForgetPasswordState state) {
                  if (state.verifyOtpState?.errorMessage != null) {
                    String msg = state.verifyOtpState!.errorMessage!;
                    AppSnackBar.error(context, msg);
                  } else if (state.verifyOtpState!.isSuccess) {
                    print("true opt");
                  }
                },
              ),
              SizedBox(height: MyResponsive.height(context, value: 16)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text(AppStrings.didNotReceiveCode), OtpResenedBtn()],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
