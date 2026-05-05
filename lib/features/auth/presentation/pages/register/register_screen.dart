import 'package:flower_app/core/helpers/app_snack_bar.dart';
import 'package:flower_app/core/helpers/my_responsive.dart';
import 'package:flower_app/core/localization/l10n/app_localizations.dart';
import 'package:flower_app/core/shared_widgets/custom_button.dart';
import 'package:flower_app/core/utils/app_constants.dart';
import 'package:flower_app/features/auth/presentation/manager/register_cubit.dart';
import 'package:flower_app/features/auth/presentation/manager/register_events.dart';
import 'package:flower_app/features/auth/presentation/manager/register_state.dart';
import 'package:flower_app/features/auth/presentation/widgets/register/have_an_account_widget.dart';
import 'package:flower_app/features/auth/presentation/widgets/register/name_fields_widget.dart';
import 'package:flower_app/features/auth/presentation/widgets/register/password_fields_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helpers/validator.dart';
import '../../widgets/register/gender_section_widget.dart';
import '../../widgets/register/terms_and_conditions_widget.dart';

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
    final cubit = context.read<RegisterCubit>();
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MyResponsive.height(context, value: 24)),
                Form(
                  key: formKey,
                  child: BlocConsumer<RegisterCubit, RegisterState>(
                    listener: (context, state) {
                      if (state.registerState.isSuccess) {
                        AppSnackBar.success(
                          context,
                          state.registerState.data!.message!,
                        );
                        Navigator.pop(context);
                      } else if (state.registerState.errorMessage != null) {
                        AppSnackBar.error(
                          context,
                          state.registerState.errorMessage!,
                        );
                      }
                    },
                    builder: (context, state) {
                      final isLoading = state.registerState.isLoading;
                      return Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          /// name
                          NameFieldsWidget(
                            firstNameController: firstNameController,
                            lastNameController: lastNameController,
                            isLoading: isLoading,
                            validationMode: state.isSubmitted
                                ? AutovalidateMode.always
                                : AutovalidateMode.disabled,
                          ),

                          SizedBox(
                            height: MyResponsive.height(context, value: 24),
                          ),

                          /// email
                          TextFormField(
                            controller: emailController,
                            enabled: !isLoading,
                            validator: Validator.email,
                            autovalidateMode: state.isSubmitted
                                ? AutovalidateMode.always
                                : AutovalidateMode.disabled,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: local.email,
                              hintText: local.enterEmail,
                            ),
                          ),
                          SizedBox(
                            height: MyResponsive.height(context, value: 24),
                          ),

                          /// passwords
                          PasswordFieldsWidget(
                            passwordController: passwordController,
                            confirmPasswordController:
                            confirmPasswordController,
                            isPasswordHidden: state.isPasswordHidden,
                            isConfirmPasswordHidden: state
                                .isConfirmPasswordHidden,
                            passwordSuffixOnTap: () =>
                                cubit.doEvents(PasswordVisibilityEvent()),
                            confirmPasswordSuffixOnTap: () =>
                                cubit.doEvents(
                                    ConfirmPasswordVisibilityEvent()),
                            isLoading: isLoading,
                            validationMode: state.isSubmitted
                                ? AutovalidateMode.always
                                : AutovalidateMode.disabled,
                          ),
                          SizedBox(
                            height: MyResponsive.height(context, value: 24),
                          ),

                          /// Phone
                          TextFormField(
                            controller: phoneController,
                            enabled: !isLoading,
                            validator: Validator.phone,
                            autovalidateMode: state.isSubmitted
                                ? AutovalidateMode.always
                                : AutovalidateMode.disabled,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              labelText: local.phoneNumber,
                              hintText: local.enterPhoneNumber,
                            ),
                          ),

                          SizedBox(
                            height: MyResponsive.height(context, value: 40),
                          ),

                          /// radio buttons
                          GenderSectionWidget(
                            gender: state.gender,
                            isLoading: isLoading,
                            onChanged: (value) {
                              cubit.doEvents(SelectGenderEvent(gender: value));
                            },
                          ),

                          SizedBox(
                            height: MyResponsive.height(context, value: 30),
                          ),


                          /// Terms And Conditions
                          TermsAndConditionsWidget(),

                          SizedBox(
                            height: MyResponsive.height(context, value: 48),
                          ),

                          /// sign up button
                          CustomButton(
                            title: local.signUp,
                            isLoading: isLoading,
                            onPressed: () {
                              cubit.doEvents(SubmitPressedEvent());

                              if (!formKey.currentState!.validate()) {
                                return;
                              }

                              cubit.doEvents(
                                SubmitRegisterEvent(
                                  firstName: firstNameController.text,
                                  lastName: lastNameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  confirmPassword:
                                  confirmPasswordController.text,
                                  phone: phoneController.text,
                                  gender: state.gender.name,
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: MyResponsive.height(context, value: 16)),

                /// Have an Account Widget
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
          ),
        ),
      ),
    );
  }
}

enum UserGender { male, female }
