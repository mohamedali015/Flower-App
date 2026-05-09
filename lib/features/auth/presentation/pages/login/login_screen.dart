import 'package:flower_app/config/route_manager/routes.dart';
import 'package:flower_app/core/helpers/my_responsive.dart';
import 'package:flower_app/core/localization/l10n/app_localizations.dart';
import 'package:flower_app/features/auth/presentation/manager/login/login_cubit.dart';
import 'package:flower_app/features/auth/presentation/manager/login/login_event.dart';
import 'package:flower_app/features/auth/presentation/manager/login/login_state.dart';
import 'package:flower_app/features/auth/presentation/widgets/login/login_form.dart';
import 'package:flower_app/features/auth/presentation/widgets/login/remember_me.dart';
import 'package:flower_app/features/auth/presentation/widgets/register/have_an_accountt_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool autoValidate = false;

  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  void _validateForm() {
    if (!autoValidate) return;
    _formKey.currentState?.validate();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final cubit = context.read<LoginCubit>();

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(local.login),
          leading: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
        body: Padding(
          padding: MyResponsive.paddingSymmetric(
            context,
            horizontal: 18,
            vertical: 10,
          ),
          child: Column(
            children: [
              BlocConsumer<LoginCubit, LoginState>(
                listenWhen: (prev, curr) =>
                    curr is LoginSuccess || curr is LoginFailure,
                listener: (context, state) {
                  if (state is LoginSuccess) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.bottomNavBarRoute,
                      (route) => false,
                    );
                  } else if (state is LoginFailure) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
                  }
                },
                builder: (context, state) {
                  final rememberMe = state.rememberMe;

                  return Column(
                    children: [
                      LoginForm(
                        local: local,
                        formKey: _formKey,
                        emailController: emailController,
                        passwordController: passwordController,
                        autoValidate: autoValidate,
                        isLoading: state is LoginLoading,
                        onChanged: _validateForm,
                      ),

                      BlocSelector<LoginCubit, LoginState, bool>(
                        selector: (state) => state.rememberMe,
                        builder: (context, rememberMe) {
                          return RememberMe(
                            rememberMe: rememberMe,
                            cubit: cubit,
                            local: local,
                          );
                        },
                      ),

                      SizedBox(height: MyResponsive.height(context, value: 48)),

                      ElevatedButton(
                        onPressed: state is LoginLoading
                            ? null
                            : () {
                                setState(() {
                                  autoValidate = true;
                                });

                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  cubit.doEvents(
                                    LoginSubmitEvent(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                      rememberMe: rememberMe,
                                    ),
                                  );
                                }
                              },
                        child: state is LoginLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Text(local.login),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: MyResponsive.height(context, value: 16)),

              HaveAnAccountWidget(
                title: local.doNotHaveAnAccount,
                actionText: local.signUp,
                onTap: () {
                  Navigator.pushNamed(context, Routes.registerRoute);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
