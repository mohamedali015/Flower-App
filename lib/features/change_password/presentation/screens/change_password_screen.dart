import 'package:flower_app/core/helpers/my_responsive.dart';
import 'package:flower_app/core/localization/l10n/app_localizations.dart';
import 'package:flower_app/core/shared_widgets/custom_button.dart';
import 'package:flower_app/core/utils/app_constants.dart';
import 'package:flower_app/features/change_password/domain/entities/change_password_request_entity.dart';
import 'package:flower_app/features/change_password/presentation/manager/cubit/change_password_cubit.dart';
import 'package:flower_app/features/change_password/presentation/manager/cubit/change_password_events.dart';
import 'package:flower_app/features/change_password/presentation/widgets/change_password_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  bool autoValidate = false;
  late TextEditingController newPasswordController;
  late TextEditingController passwordController;
  late FocusNode newPasswordFocus;
  late FocusNode confirmPasswordFocus;

  @override
  void initState() {
    super.initState();
    newPasswordController = TextEditingController();
    passwordController = TextEditingController();
    newPasswordFocus = FocusNode();
    confirmPasswordFocus = FocusNode();
  }

  void _validateForm() {
    if (!autoValidate) return;
    _formKey.currentState?.validate();
  }

  @override
  void dispose() {
    newPasswordController.dispose();
    passwordController.dispose();
    newPasswordFocus.dispose();
    confirmPasswordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          title: Text(local.resetPassword),
        ),
        body: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
          listener: (context, state) {
            if (state is ChangePasswordSuccess) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(local.resetPassword)));
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  Navigator.pop(context);
                }
              });
            }

            if (state is ChangePasswordError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
            }
          },
          builder: (context, state) {
            final isLoading = state is ChangePasswordLoading;
            return Padding(
              padding: MyResponsive.paddingSymmetric(
                context,
                horizontal: AppConstants.paddingHorizontal,
                vertical: 10,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ChangePasswordForm(
                      formKey: _formKey,
                      confirmPasswordFocus: confirmPasswordFocus,
                      newPasswordFocus: newPasswordFocus,
                      newPasswordController: newPasswordController,
                      passwordController: passwordController,
                      autoValidate: autoValidate,
                      isLoading: isLoading,
                      local: local,
                      onChanged: _validateForm,
                    ),
                    SizedBox(height: MyResponsive.height(context, value: 24)),
                    CustomButton(
                      title: local.update,
                      onPressed: isLoading
                          ? null
                          : () {
                              final isValid =
                                  _formKey.currentState?.validate() ?? false;
                              if (!isValid) {
                                setState(() {
                                  autoValidate = true;
                                });
                                return;
                              }

                              context.read<ChangePasswordCubit>().doEvents(
                                SubmitChangePasswordEvent(
                                  changePasswordRequestEntity:
                                      ChangePasswordRequestEntity(
                                        password: passwordController.text
                                            .trim(),
                                        newPassword: newPasswordController.text
                                            .trim(),
                                      ),
                                ),
                              );
                            },
                      isLoading: isLoading,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
