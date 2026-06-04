import 'package:flower_app/core/helpers/my_responsive.dart';
import 'package:flower_app/core/shared_widgets/svg_wrapper.dart';
import 'package:flower_app/core/utils/app_assets.dart';
import 'package:flower_app/core/utils/app_colors.dart';
import 'package:flower_app/core/utils/app_text_styles.dart';
import 'package:flower_app/features/profile/presentation/widgets/icon_text_widget.dart';
import 'package:flower_app/features/user_address/domain/entities/address.dart';
import 'package:flutter/material.dart';

import '../../../../core/localization/l10n/app_localizations.dart';

class AddressCard extends StatelessWidget {
  AddressCard(this.address, {super.key});

  Address address;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF9F9F9),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF535353).withOpacity(0.25),
                offset: Offset.zero,
                blurRadius: 4,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: IconTextWidget(
                      text: address.city ?? "",
                      iconPath: AppAssets.location,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const SvgWrapper(path: AppAssets.bin),
                        ),
                        SizedBox(width: MyResponsive.width(context, value: 3)),
                        IconButton(
                          onPressed: () {},
                          icon: const SvgWrapper(path: AppAssets.edit),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              address.placeMarks!.isNotEmpty
                  ? Text(
                      style: AppTextStyles.regular13(
                        context,
                      ).copyWith(color: AppColors.grayDark, fontSize: 12),
                      address.placeMarks?.first.subAdministrativeArea ?? "",
                    )
                  : const SizedBox(),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
