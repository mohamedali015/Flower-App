import 'package:flower_app/config/route_manager/routes.dart';
import 'package:flower_app/core/helpers/app_snack_bar.dart';
import 'package:flower_app/core/helpers/my_responsive.dart';
import 'package:flower_app/core/helpers/validator.dart';
import 'package:flower_app/core/utils/app_colors.dart';
import 'package:flower_app/core/utils/app_text_styles.dart';
import 'package:flower_app/core/values/app_strings.dart';
import 'package:flower_app/features/forget_password/presentation/manager/cubit/forget_password_cubit.dart';
import 'package:flower_app/features/forget_password/presentation/manager/state/forget_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_constants.dart';
import '../manager/event/forget_password_event.dart';

class ForgetPasswordEnterEmailView extends StatefulWidget {
  const ForgetPasswordEnterEmailView({super.key});

  @override
  State<ForgetPasswordEnterEmailView> createState() =>
      _ForgetPasswordEnterEmailViewState();
}

class _ForgetPasswordEnterEmailViewState
    extends State<ForgetPasswordEnterEmailView> {
  late final TextEditingController _emailTextController;

  @override
  void initState() {
    _emailTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgetPasswordCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.password),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: SafeArea(
        child: Padding(
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
                  controller: _emailTextController,
                  decoration: const InputDecoration(
                    labelText: AppStrings.email,
                    hintText: AppStrings.enterYouEmail,
                  ),
                  validator: (value) => Validator.email(value),
                ),
                SizedBox(height: MyResponsive.height(context, value: 42)),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      cubit.doEvent(SendEmailEvent(_emailTextController.text));
                    }
                  },
                  child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
                    builder: (BuildContext context, state) {
                      return _buildWidget(state);
                    },
                    listenWhen: (previous, current) {
                      return (current.sendEmailState?.isLoading == false &&
                          previous.sendEmailState != current.sendEmailState);
                    },
                    listener: (BuildContext context, state) {
                      _listenActions(state, context, cubit);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWidget(ForgetPasswordState state) {
    if (state.sendEmailState?.isLoading ?? false) {
      return const CircularProgressIndicator(color: AppColors.white);
    } else {
      return const Text(AppStrings.confirm);
    }
  }

  void _listenActions(
    ForgetPasswordState state,
    BuildContext context,
    ForgetPasswordCubit cubit,
  ) {
    if (state.sendEmailState?.errorMessage != null) {
      final String msg = state.sendEmailState!.errorMessage!;
      AppSnackBar.error(context, msg);
    } else {
      Navigator.pushNamed(
        context,
        Routes.forgetPasswordOtpViewRoute,
        arguments: cubit,
      );
    }
  }
}
