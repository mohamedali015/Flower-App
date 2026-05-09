import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../core/helpers/my_responsive.dart';
import '../../../../../core/utils/app_colors.dart';

class CustomOtpField extends StatelessWidget {
  const CustomOtpField({
    super.key,
    this.errorController,
    required this.onCompleted,
    this.isLoading = false,
    this.controller,
  });

  final ValueChanged<String> onCompleted;
  final StreamController<ErrorAnimationType>? errorController;
  final TextEditingController? controller;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      controller: controller,
      length: 6,
      autoFocus: true,

      enablePinAutofill: true,
      beforeTextPaste: (_) => true,

      // cursorColor: AppColors.primary,
      keyboardType: TextInputType.number,
      animationType: AnimationType.scale,
       errorAnimationController: errorController,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(
          MyResponsive.radius(context, value: 16),
        ),
        borderWidth: 1,
        fieldHeight: MyResponsive.height(context, value: 65),
        fieldWidth: MyResponsive.width(context, value: 50),
        activeColor: AppColors.hintTextGray,
        activeFillColor: AppColors.baseWhite,
        inactiveColor: AppColors.otpContainerBlue,
        inactiveFillColor: AppColors.otpContainerBlue,
        selectedColor: AppColors.otpContainerBlue,
        selectedFillColor: AppColors.otpContainerBlue,
        errorBorderColor: AppColors.error,
        disabledColor: AppColors.otpContainerBlue,
      ),
      animationDuration: const Duration(milliseconds: 300),
      enableActiveFill: true,
      enabled: isLoading ? false : true,
      onCompleted: onCompleted,
    );
  }
}
