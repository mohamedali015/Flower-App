import 'package:flower_app/core/helpers/my_responsive.dart';
import 'package:flower_app/core/localization/l10n/app_localizations.dart';
import 'package:flower_app/core/utils/app_colors.dart';
import 'package:flower_app/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import '../../manager/register_state.dart';

class GenderSectionWidget extends StatelessWidget {
  final UserGender gender;
  final bool isLoading;
  final Function(UserGender) onChanged;

  const GenderSectionWidget({
    super.key,
    required this.gender,
    required this.isLoading,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Opacity(
      opacity: isLoading ? .6 : 1,
      child: IgnorePointer(
        ignoring: isLoading,

        child: RadioGroup<UserGender>(
          groupValue: gender,
          onChanged: (value) {
            if (value != null) {
              onChanged(value);
            }
          },
          child: Row(
            children: [
              /// Title
              Text(
                local.gender,
                style: AppTextStyles.medium18(
                  context,
                ).copyWith(color: AppColors.grayDark),
              ),

              SizedBox(width: MyResponsive.width(context, value: 40)),

              /// Female
              Material(
                color: Colors.transparent,
                child: GestureDetector(
                  onTap: () => onChanged(UserGender.female),
                  child: Row(
                    children: [
                      Transform.scale(
                        scale: MyResponsive.width(context, value: 1),
                        child: Radio<UserGender>(
                          value: UserGender.female,
                          activeColor: AppColors.primaryColor,
                        ),
                      ),
                      Text(
                        local.female,
                        style: AppTextStyles.regular14(context),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(width: MyResponsive.width(context, value: 16)),

              /// Male
              Material(
                color: Colors.transparent,
                child: GestureDetector(
                  onTap: () => onChanged(UserGender.male),
                  child: Row(
                    children: [
                      Transform.scale(
                        scale: MyResponsive.width(context, value: 1),
                        child: Radio<UserGender>(
                          value: UserGender.male,
                          activeColor: AppColors.primaryColor,
                        ),
                      ),
                      Text(local.male, style: AppTextStyles.regular14(context)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
