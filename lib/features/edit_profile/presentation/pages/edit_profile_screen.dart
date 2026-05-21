import 'dart:io';

import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/config/user/domain/entities/user_entity.dart';
import 'package:flower_app/config/user/manager/user_cubit.dart';
import 'package:flower_app/config/user/manager/user_events.dart';
import 'package:flower_app/config/user/manager/user_state.dart';
import 'package:flower_app/core/helpers/app_snack_bar.dart';
import 'package:flower_app/core/helpers/get_phone_without_country_code.dart';
import 'package:flower_app/core/helpers/validator.dart';
import 'package:flower_app/core/localization/l10n/app_localizations.dart';
import 'package:flower_app/core/shared_widgets/custom_button.dart';
import 'package:flower_app/core/shared_widgets/custom_error_widget.dart';
import 'package:flower_app/core/shared_widgets/custom_loading_indicator.dart';
import 'package:flower_app/core/utils/app_colors.dart';
import 'package:flower_app/core/utils/app_constants.dart';
import 'package:flower_app/core/utils/app_text_styles.dart';
import 'package:flower_app/features/auth/presentation/widgets/register/custom_phone_field.dart';
import 'package:flower_app/features/auth/presentation/widgets/register/name_fields_widget.dart';
import 'package:flower_app/features/edit_profile/presentation/manager/edit_profile_cubit.dart';
import 'package:flower_app/features/edit_profile/presentation/manager/edit_profile_events.dart';
import 'package:flower_app/features/edit_profile/presentation/manager/edit_profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late KeyboardVisibilityController keyboardVisibilityController;

  final firstNameFocus = FocusNode();
  final lastNameFocus = FocusNode();
  final emailFocus = FocusNode();
  final phoneFocus = FocusNode();

  File? selectedImage;

  bool isInitialized = false;

  @override
  void initState() {
    super.initState();

    context.read<UserCubit>().doEvent(GetUserDataEvent());

    keyboardVisibilityController = KeyboardVisibilityController();

    keyboardVisibilityController.onChange.listen((visible) {
      if (!visible) {
        FocusManager.instance.primaryFocus?.unfocus();
      }
    });

    firstNameController.addListener(onChanged);
    lastNameController.addListener(onChanged);
    emailController.addListener(onChanged);
    phoneController.addListener(onChanged);
  }

  void _fillUserData(UserEntity user) {
    firstNameController.text = user.firstName;
    lastNameController.text = user.lastName;
    emailController.text = user.email;
    phoneController.text = user.phone;
  }

  void onChanged() {
    final user = context.read<UserCubit>().state.user;

    if (user == null) return;

    context.read<EditProfileCubit>().doEvent(
      CheckChangesEvent(
        user: user,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        phone: phoneController.text,
      ),
    );
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();

    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage == null) return;

    final image = File(pickedImage.path);

    setState(() {
      selectedImage = image;
    });

    if (!mounted) return;

    context.read<EditProfileCubit>().doEvent(
      UploadProfileImageEvent(image: image),
    );
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    firstNameFocus.dispose();
    lastNameFocus.dispose();
    emailFocus.dispose();
    phoneFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(local.editProfile),

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },

          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),

      body: BlocBuilder<UserCubit, UserState>(
        buildWhen: (previous, current) {
          return previous.isLoading != current.isLoading ||
              previous.user != current.user ||
              previous.error != current.error;
        },

        builder: (context, userState) {
          if (userState.isLoading) {
            return const CustomLoadingIndicator();
          }

          if (userState.error != null) {
            return CustomErrorWidget(
              errorMessage: userState.error!,

              haveTryAgain: true,

              onPressed: () async {
                context.read<UserCubit>().doEvent(GetUserDataEvent());
              },
            );
          }

          final user = userState.user!;

          if (!isInitialized) {
            _fillUserData(user);

            isInitialized = true;
          }

          return BlocListener<EditProfileCubit, EditProfileState>(
            listenWhen: (previous, current) {
              return previous.editProfileState != current.editProfileState ||
                  previous.uploadProfileImageState !=
                      current.uploadProfileImageState;
            },

            listener: (context, state) {
              if (state.editProfileState.isSuccess) {
                final updatedUser = state.editProfileState.data!.user;

                context.read<UserCubit>().doEvent(
                  SetUserDataEvent(user: updatedUser),
                );

                AppSnackBar.success(
                  context,

                  state.editProfileState.data?.message ?? '',
                );
              }

              if (state.editProfileState.errorMessage != null) {
                AppSnackBar.error(
                  context,

                  state.editProfileState.errorMessage!,
                );
              }

              if (state.uploadProfileImageState.errorMessage != null) {
                AppSnackBar.error(
                  context,

                  state.uploadProfileImageState.errorMessage!,
                );
              }
            },

            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.paddingHorizontal,
                ),

                child: RefreshIndicator(
                  onRefresh: () async {
                    isInitialized = false;
                    context.read<UserCubit>().doEvent(GetUserDataEvent());
                  },

                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),

                    child: BlocSelector<EditProfileCubit, EditProfileState, bool>(
                      selector: (state) {
                        return state.editProfileState.isLoading;
                      },

                      builder: (context, isLoading) {
                        return Form(
                          key: formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,

                          child: Column(
                            children: [
                              const SizedBox(height: 20),

                              /// IMAGE
                              BlocSelector<
                                EditProfileCubit,
                                EditProfileState,
                                BaseState<bool>
                              >(
                                selector: (state) {
                                  return state.uploadProfileImageState;
                                },

                                builder: (context, uploadState) {
                                  return GestureDetector(
                                    onTap: uploadState.isLoading
                                        ? null
                                        : pickImage,

                                    child: Stack(
                                      clipBehavior: Clip.none,

                                      children: [
                                        CircleAvatar(
                                          radius: 50,
                                          backgroundImage: selectedImage != null
                                              ? FileImage(selectedImage!)
                                                    as ImageProvider
                                              : NetworkImage(user.userPhoto),
                                        ),

                                        PositionedDirectional(
                                          bottom: 0,
                                          end: 5,

                                          child: Container(
                                            padding: const EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                              color: AppColors.lightPink,
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),

                                            child: uploadState.isLoading
                                                ? const SizedBox(
                                                    width: 18,
                                                    height: 18,

                                                    child:
                                                        CircularProgressIndicator(
                                                          strokeWidth: 2,
                                                        ),
                                                  )
                                                : const Icon(
                                                    Icons.camera_alt_outlined,
                                                    size: 18,
                                                  ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),

                              const SizedBox(height: 24),

                              /// NAME
                              NameFieldsWidget(
                                firstNameController: firstNameController,
                                lastNameController: lastNameController,
                                isLoading: isLoading,
                                firstNameFocus: firstNameFocus,
                                lastNameFocus: lastNameFocus,
                                emailFocus: emailFocus,
                              ),

                              const SizedBox(height: 24),

                              /// EMAIL
                              TextFormField(
                                controller: emailController,
                                enabled: !isLoading,
                                validator: Validator.email,
                                keyboardType: TextInputType.emailAddress,
                                focusNode: emailFocus,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(
                                    context,
                                  ).requestFocus(phoneFocus);
                                },
                                decoration: InputDecoration(
                                  labelText: local.email,

                                  hintText: local.enterEmail,
                                ),
                              ),

                              const SizedBox(height: 24),

                              /// PHONE
                              CustomPhoneField(
                                initialValue: getPhoneWithoutCountryCode(
                                  user.phone,
                                ),
                                phoneController: phoneController,
                                phoneFocus: phoneFocus,
                                isLoading: isLoading,
                              ),

                              const SizedBox(height: 24),

                              /// PASSWORD
                              TextFormField(
                                initialValue: local.password,
                                readOnly: true,
                                enabled: !isLoading,
                                obscureText: true,
                                obscuringCharacter: '★',
                                decoration: InputDecoration(
                                  labelText: local.password,
                                  suffixIcon: IconButton(
                                    icon: Text(
                                      local.change,
                                      style: AppTextStyles.semiBold12(
                                        context,
                                      ).copyWith(color: AppColors.primaryColor),
                                    ),

                                    onPressed: () {},
                                  ),
                                ),
                              ),

                              const SizedBox(height: 140),

                              /// BUTTON
                              BlocSelector<
                                EditProfileCubit,
                                EditProfileState,
                                bool
                              >(
                                selector: (state) {
                                  return state.isChanged;
                                },

                                builder: (context, isChanged) {
                                  return CustomButton(
                                    title: local.update,
                                    isLoading: isLoading,
                                    onPressed: isChanged
                                        ? () {
                                            if (!formKey.currentState!
                                                .validate()) {
                                              return;
                                            }

                                            context
                                                .read<EditProfileCubit>()
                                                .doEvent(
                                                  EditProfileEvent(
                                                    firstName:
                                                        firstNameController.text
                                                            .trim(),

                                                    lastName: lastNameController
                                                        .text
                                                        .trim(),

                                                    email: emailController.text
                                                        .trim(),

                                                    phone: phoneController.text
                                                        .trim(),
                                                  ),
                                                );
                                          }
                                        : null,
                                  );
                                },
                              ),

                              const SizedBox(height: 20),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
