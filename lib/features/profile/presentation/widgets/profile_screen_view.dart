import 'package:flower_app/config/user/domain/entities/user_entity.dart';
import 'package:flower_app/core/shared_widgets/cached_network_image_wrapper.dart';
import 'package:flower_app/core/utils/app_text_styles.dart';
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
  const ProfileScreenView({required this.user});

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
      child: Padding(
        padding: MyResponsive.paddingSymmetric(context, vertical: 11.5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProfileScreenSettingItemWidget(
                left: Image.asset(
                  AppAssets.logo,
                  height: MyResponsive.height(context, value: 25),
                  width: MyResponsive.width(context, value: 90),
                ),
                right: IconButton(
                  onPressed: () {},
                  icon: const SvgWrapper(path: AppAssets.notification),
                ),
              ),
              SizedBox(height: MyResponsive.height(context, value: 16)),
              Center(
                child: Padding(
                  padding: MyResponsive.paddingOnly(
                    context,
                    top: 16,
                    bottom: 32,
                  ),
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
                            onPressed: () {},
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
              ProfileScreenSettingItemWidget(
                left: IconTextWidget(
                  text: locale.myOrders,
                  iconPath: AppAssets.myOrders,
                ),
                right: IconButton(
                  onPressed: () {},
                  icon: const SvgWrapper(path: AppAssets.iosForwardBtn),
                ),
              ),
              ProfileScreenSettingItemWidget(
                left: IconTextWidget(
                  text: locale.myAddress,
                  iconPath: AppAssets.location,
                ),
                right: IconButton(
                  onPressed: () {},
                  icon: const SvgWrapper(path: AppAssets.iosForwardBtn),
                ),
              ),
              const Divider(color: AppColors.hintTextGray, endIndent: 0),
              Row(
                children: [
                  Switch(
                    padding: MyResponsive.paddingSymmetric(
                      context,
                      horizontal: 4,
                    ),
                    activeTrackColor: AppColors.primaryColor,
                    value: switchState,
                    onChanged: (value) {
                      setState(() {
                        switchState = !switchState;
                      });
                    },
                  ),
                  Text(locale.notification),
                ],
              ),

              const Divider(color: AppColors.hintTextGray, endIndent: 0),
              ProfileScreenSettingItemWidget(
                left: IconTextWidget(
                  text: locale.language,
                  iconPath: AppAssets.language,
                ),
                right: TextButton(
                  onPressed: () => _changeLocale(context),
                  child: Text(
                    currentLocale,
                    style: AppTextStyles.regular12(
                      context,
                    ).copyWith(fontSize: 11, color: AppColors.primaryColor),
                  ),
                ),
              ),

              ProfileScreenSettingItemWidget(
                left: Text(
                  locale.aboutUs,
                  style: AppTextStyles.regular14(
                    context,
                  ).copyWith(fontSize: 13),
                ),
                right: IconButton(
                  onPressed: () {},
                  icon: const SvgWrapper(path: AppAssets.iosForwardBtn),
                ),
              ),
              ProfileScreenSettingItemWidget(
                left: Text(
                  locale.termsAndConditions,
                  style: AppTextStyles.regular14(
                    context,
                  ).copyWith(fontSize: 13),
                ),
                right: IconButton(
                  onPressed: () {},
                  icon: const SvgWrapper(path: AppAssets.iosForwardBtn),
                ),
              ),
              const Divider(color: AppColors.hintTextGray, endIndent: 0),
              ProfileScreenSettingItemWidget(
                left: IconTextWidget(
                  text: locale.logout,
                  iconPath: AppAssets.logout,
                ),
                right: IconButton(
                  onPressed: () {},
                  icon: const SvgWrapper(path: AppAssets.logout),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _changeLocale(BuildContext context) {
    final localeCubit = context.read<LocaleCubit>();
    final currentLocale = localeCubit.state.languageCode;
    localeCubit.changeLanguage(currentLocale == 'en' ? 'ar' : 'en');
  }
}
