import 'package:flower_app/features/forget_password/presentation/manager/event/forget_password_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/values/app_strings.dart';
import '../manager/cubit/forget_password_cubit.dart';
import '../manager/state/forget_password_state.dart';

class OtpResenedBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
      builder: (BuildContext context, state) {
        if (state.canResend) {
          return TextButton(
            onPressed: () {
              context.read<ForgetPasswordCubit>().doEvent(ResendCodeEvent());
            },
            child: BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
              builder: (context, state) {
                if (state.sendEmailState!.isLoading) {
                  return CircularProgressIndicator();
                } else {
                  return Text(
                    AppStrings.resend,
                    style: AppTextStyles.regular16(context).copyWith(
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.primaryColor,
                      color: AppColors.primaryColor,
                    ),
                  );
                }
              },
            ),
          );
        }
        return Text('${AppStrings.resendCodeIn} ${state.remainingSeconds}s');
      },
    );
  }
}
