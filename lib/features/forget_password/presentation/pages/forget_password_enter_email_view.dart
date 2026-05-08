import 'package:flower_app/core/helpers/my_responsive.dart';
import 'package:flower_app/core/utils/app_colors.dart';
import 'package:flower_app/core/utils/app_text_styles.dart';
import 'package:flower_app/core/values/app_strings.dart';
import 'package:flower_app/features/forget_password/presentation/manager/cubit/forget_password_cubit.dart';
import 'package:flower_app/features/forget_password/presentation/manager/state/forget_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_constants.dart';
import '../manager/event/forget_password_event.dart';

class ForgetPasswordEnterEmailView extends StatelessWidget {
  ForgetPasswordEnterEmailView();

  final TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgetPasswordCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.password),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: MyResponsive.paddingSymmetric(
            context,
            horizontal: AppConstants.paddingHorizontal,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: MyResponsive.height(context, value: 40)),
              Text(
                AppStrings.forgetPassword,
                textAlign: TextAlign.center,
                style: AppTextStyles.medium18(context),
              ),
              SizedBox(height: MyResponsive.height(context, value: 16)),
              Text(
                AppStrings.enterYourEmailAssociatedToYourAccount,
                textAlign: TextAlign.center,
                style: AppTextStyles.regular14(context),
              ),
              SizedBox(height: MyResponsive.height(context, value: 32)),
              TextFormField(
                decoration: InputDecoration(
                  labelText: AppStrings.email,
                  hintText: AppStrings.enterYouEmail,
                ),
                controller: _emailTextController,
              ),
              SizedBox(height: MyResponsive.height(context, value: 42)),
              ElevatedButton(
                onPressed: () {
                  cubit.doEvent(SendEmailEvent(_emailTextController.text));
                },
                child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
                  builder: (BuildContext context, state) {
                    if (state.sendEmailState?.isLoading ?? false) {
                      return CircularProgressIndicator(color: AppColors.white);
                    } else {
                      return Text(AppStrings.confirm);
                    }
                  },
                  listener: (BuildContext context, state) {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
