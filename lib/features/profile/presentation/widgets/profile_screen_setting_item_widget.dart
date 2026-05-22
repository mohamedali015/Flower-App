import 'package:flutter/material.dart';

import '../../../../core/helpers/my_responsive.dart';

class ProfileScreenSettingItemWidget extends StatelessWidget {
  const ProfileScreenSettingItemWidget({
    super.key,
    required this.left,
    required this.right,
  });

  final Widget left;
  final Widget right;

  @override
  Widget build(BuildContext context) {
    final isArabic =
        Directionality.of(context) == TextDirection.rtl;

    return Padding(
      padding: MyResponsive.paddingSymmetric(
        context,
        horizontal: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          left,

          Transform.flip(
            flipX: isArabic,
            child: right,
          ),
        ],
      ),
    );
  }
}