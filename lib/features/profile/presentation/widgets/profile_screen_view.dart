import 'package:flower_app/config/route_manager/routes.dart';
import 'package:flower_app/config/user/domain/entities/user_entity.dart';
import 'package:flower_app/core/shared_widgets/cached_network_image_wrapper.dart';
import 'package:flower_app/core/utils/app_text_styles.dart';
import 'package:flower_app/features/logout/presentation/logout_dialog.dart';
import 'package:flower_app/features/profile/presentation/widgets/profile_screen_setting_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/cubit/locale/locale_cubit.dart';
import '../../../../core/helpers/my_responsive.dart';
import '../../../../core/localization/l10n/app_localizations.dart';
import '../../../../core/shared_widgets/svg_wrapper.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import 'icon_text_widget.dart';

class ProfileScreenView extends StatefulWidget {
  const ProfileScreenView({super.key, required this.user});

  final UserEntity user;

  @override
  State<ProfileScreenView> createState() => _ProfileScreenViewState();
}

class _ProfileScreenViewState extends State<ProfileScreenView> {
  bool switchState = true;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final localCubit = context.read<LocaleCubit>();
    final currentLocale = localCubit.state.languageCode == "er"
        ? locale.english
        : locale.arabic;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.editProfileScreenRoute);
              },
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: MyResponsive.paddingSymmetric(
                        context,
                        vertical: 8,
                      ),
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        color: AppColors.lightPink,
                        shape: BoxShape.circle,
                      ),
                      child: CachedNetworkImageWrapper(
                        height: MyResponsive.height(context, value: 81),
                        width: MyResponsive.width(context, value: 81),
                        imagePath: widget.user.userPhoto,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.user.firstName,
                          style: AppTextStyles.medium18(context),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              Routes.editProfileScreenRoute,
                            );
                          },
                          icon: const SvgWrapper(path: AppAssets.pen),
                        ),
                      ],
                    ),
                    SizedBox(height: MyResponsive.height(context, value: 6)),
                    Text(
                      widget.user.email,
                      style: AppTextStyles.medium18(
                        context,
                      ).copyWith(color: AppColors.grayDark),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            ProfileScreenSettingItemWidget(
              onTap: () {},
              start: IconTextWidget(
                text: locale.myOrders,
                iconPath: AppAssets.myOrders,
              ),
              end: IconButton(
                onPressed: () {},
                icon: const SvgWrapper(
                  path: AppAssets.iosForwardBtn,
                  width: 24,
                  height: 24,
                ),
              ),
            ),
            ProfileScreenSettingItemWidget(
              onTap: () {
                Navigator.pushNamed(context, Routes.savedAddressesRoute);
              },
              start: IconTextWidget(
                text: locale.myAddress,
                iconPath: AppAssets.location,
              ),
              end: IconButton(
                onPressed: () {},
                icon: const SvgWrapper(
                  path: AppAssets.iosForwardBtn,
                  width: 24,
                  height: 24,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Divider(color: AppColors.hintTextGray, endIndent: 0),
            const SizedBox(height: 10),
            ProfileScreenSettingItemWidget(
              onTap: () {},
              start: Row(
                children: [
                  Switch(
                    activeTrackColor: AppColors.primaryColor,
                    value: switchState,
                    onChanged: (value) {
                      setState(() {
                        switchState = !switchState;
                      });
                    },
                  ),
                  const SizedBox(width: 4),
                  Text(locale.notification),
                ],
              ),

              end: IconButton(
                onPressed: () {},
                icon: const SvgWrapper(
                  path: AppAssets.iosForwardBtn,
                  width: 24,
                  height: 24,
                ),
              ),
            ),

            const SizedBox(height: 10),
            const Divider(color: AppColors.hintTextGray, endIndent: 0),
            const SizedBox(height: 10),
            ProfileScreenSettingItemWidget(
              onTap: () => _showBottomSheet(context),
              start: IconTextWidget(
                text: locale.language,
                iconPath: AppAssets.language,
              ),
              end: TextButton(
                onPressed: () => _showBottomSheet(context),
                child: Text(
                  currentLocale,
                  style: AppTextStyles.regular12(
                    context,
                  ).copyWith(fontSize: 11, color: AppColors.primaryColor),
                ),
              ),
            ),

            ProfileScreenSettingItemWidget(
              onTap: () {},
              start: Text(
                locale.aboutUs,
                style: AppTextStyles.regular13(context),
              ),
              end: IconButton(
                onPressed: () {},
                icon: const SvgWrapper(
                  path: AppAssets.iosForwardBtn,
                  width: 24,
                  height: 24,
                ),
              ),
            ),
            ProfileScreenSettingItemWidget(
              onTap: () {},

              start: Text(
                locale.termsAndConditions,
                style: AppTextStyles.regular13(context),
              ),
              end: IconButton(
                onPressed: () {},
                icon: const SvgWrapper(
                  path: AppAssets.iosForwardBtn,
                  width: 24,
                  height: 24,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Divider(color: AppColors.hintTextGray, endIndent: 0),
            const SizedBox(height: 16),

            ProfileScreenSettingItemWidget(
              onTap: () async {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) => const LogoutDialog(),
                );
              },
              start: IconTextWidget(
                text: locale.logout,
                iconPath: AppAssets.logout,
              ),
              end: IconButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) => const LogoutDialog(),
                  );
                },
                icon: const SvgWrapper(path: AppAssets.logout),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final localeCubit = context.read<LocaleCubit>();

    showModalBottomSheet(
      backgroundColor: AppColors.background,
      context: context,
      builder: (context) {
        return RadioGroup<String>(
          groupValue: localeCubit.state.languageCode,
          onChanged: (value) {
            localeCubit.changeLanguage(value!);
            Navigator.pop(context);
          },
          child: Padding(
            padding: MyResponsive.paddingOnly(
              context,
              bottom: 16,
              top: 36,
              start: 16,
              end: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: MyResponsive.width(context, value: 80),
                  height: MyResponsive.height(context, value: 4),
                  color: AppColors.grayDark,
                ),

                SizedBox(height: MyResponsive.height(context, value: 16)),

                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    locale.changeLanguage,
                    style: AppTextStyles.bold20(
                      context,
                    ).copyWith(color: AppColors.primaryColor),
                  ),
                ),

                SizedBox(height: MyResponsive.height(context, value: 16)),

                _languageCard(
                  context: context,
                  title: locale.arabic,
                  value: "ar",
                  onTap: () {
                    localeCubit.changeLanguage("ar");
                    Navigator.pop(context);
                  },
                ),

                SizedBox(height: MyResponsive.height(context, value: 16)),

                _languageCard(
                  context: context,
                  title: locale.english,
                  value: "en",
                  onTap: () {
                    localeCubit.changeLanguage("en");
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _languageCard({
    required BuildContext context,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(
        MyResponsive.radius(context, value: 8),
      ),
      onTap: onTap,
      child: Container(
        padding: MyResponsive.paddingSymmetric(
          context,
          vertical: 18.5,
          horizontal: 16,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            MyResponsive.radius(context, value: 8),
          ),
          color: AppColors.white,
          boxShadow: const [
            BoxShadow(
              color: Color(0x1A000000),
              blurRadius: 5,
              spreadRadius: 0,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(title, style: AppTextStyles.medium18(context)),
            ),

            Radio<String>(value: value, activeColor: AppColors.primaryColor),
          ],
        ),
      ),
    );
  }
}
