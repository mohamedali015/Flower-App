import 'package:flower_app/core/helpers/app_snack_bar.dart';
import 'package:flower_app/core/helpers/my_responsive.dart';
import 'package:flower_app/core/localization/l10n/app_localizations.dart';
import 'package:flower_app/core/shared_widgets/custom_button.dart';
import 'package:flower_app/core/utils/app_constants.dart';
import 'package:flower_app/features/auth/presentation/manager/register_cubit.dart';
import 'package:flower_app/features/auth/presentation/manager/register_events.dart';
import 'package:flower_app/features/auth/presentation/manager/register_state.dart';
import 'package:flower_app/features/auth/presentation/widgets/register/gender_section_widget.dart';
import 'package:flower_app/features/auth/presentation/widgets/register/have_an_account_widget.dart';
import 'package:flower_app/features/auth/presentation/widgets/register/name_fields_widget.dart';
import 'package:flower_app/features/auth/presentation/widgets/register/password_fields_widget.dart';
import 'package:flower_app/features/auth/presentation/widgets/register/terms_and_conditions_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helpers/validator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController firstNameController = TextEditingController();

  final TextEditingController lastNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(local.signUp),
      ),
      body: SafeArea(
        child: Padding(
          padding: MyResponsive.paddingSymmetric(
            context,
            horizontal: AppConstants.paddingHorizontal,
          ),
          child: BlocConsumer<RegisterCubit, RegisterState>(
            listenWhen: (previous, current) =>
                previous.registerState != current.registerState,
            listener: (context, state) {
              if (state.registerState.isSuccess) {
                AppSnackBar.success(context, state.registerState.data!.message);

                Navigator.pop(context);
              } else if (state.registerState.errorMessage != null) {
                AppSnackBar.error(context, state.registerState.errorMessage!);
              }
            },
            buildWhen: (previous, current) =>
                previous.gender != current.gender ||
                previous.isSubmitted != current.isSubmitted ||
                previous.registerState.isLoading !=
                    current.registerState.isLoading,
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: MyResponsive.height(context, value: 24)),

                    Form(
                      key: formKey,
                      autovalidateMode: state.isSubmitted
                          ? AutovalidateMode.always
                          : AutovalidateMode.disabled,
                      child: Column(
                        children: [
                          /// Name Fields
                          NameFieldsWidget(
                            firstNameController: firstNameController,
                            lastNameController: lastNameController,
                            isLoading: state.registerState.isLoading,
                          ),

                          SizedBox(
                            height: MyResponsive.height(context, value: 24),
                          ),

                          /// Email Field
                          TextFormField(
                            controller: emailController,
                            enabled: !state.registerState.isLoading,
                            validator: Validator.email,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: local.email,
                              hintText: local.enterEmail,
                            ),
                          ),

                          SizedBox(
                            height: MyResponsive.height(context, value: 24),
                          ),

                          /// Password Fields
                          PasswordFieldsWidget(
                            passwordController: passwordController,
                            confirmPasswordController:
                                confirmPasswordController,
                            isLoading: state.registerState.isLoading,
                          ),

                          SizedBox(
                            height: MyResponsive.height(context, value: 24),
                          ),

                          /// Phone Field
                          TextFormField(
                            controller: phoneController,
                            enabled: !state.registerState.isLoading,
                            validator: Validator.phone,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              labelText: local.phoneNumber,
                              hintText: local.enterPhoneNumber,
                            ),
                          ),

                          SizedBox(
                            height: MyResponsive.height(context, value: 40),
                          ),

                          /// Gender Section
                          GenderSectionWidget(
                            gender: state.gender,
                            isLoading: state.registerState.isLoading,
                            onChanged: (value) {
                              context.read<RegisterCubit>().doEvents(
                                SelectGenderEvent(gender: value),
                              );
                            },
                          ),

                          SizedBox(
                            height: MyResponsive.height(context, value: 30),
                          ),

                          /// Terms
                          const TermsAndConditionsWidget(),

                          SizedBox(
                            height: MyResponsive.height(context, value: 48),
                          ),

                          /// Button
                          CustomButton(
                            title: local.signUp,
                            isLoading: state.registerState.isLoading,
                            onPressed: () {
                              context.read<RegisterCubit>().doEvents(
                                SubmitPressedEvent(),
                              );

                              if (!formKey.currentState!.validate()) {
                                return;
                              }

                              context.read<RegisterCubit>().doEvents(
                                SubmitRegisterEvent(
                                  firstName: firstNameController.text.trim(),
                                  lastName: lastNameController.text.trim(),
                                  email: emailController.text.trim(),
                                  password: passwordController.text,
                                  confirmPassword:
                                      confirmPasswordController.text,
                                  phone: phoneController.text.trim(),
                                  gender: state.gender.name,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: MyResponsive.height(context, value: 16)),

                    /// Have Account
                    HaveAnAccountWidget(
                      title: local.alreadyHaveAccount,
                      actionText: local.login,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),

                    SizedBox(height: MyResponsive.height(context, value: 20)),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
