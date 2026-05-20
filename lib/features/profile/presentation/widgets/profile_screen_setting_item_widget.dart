import 'package:flutter/material.dart';

import '../../../../core/helpers/my_responsive.dart';

class ProfileScreenSettingItemWidget extends StatelessWidget {
  const ProfileScreenSettingItemWidget({
    required this.left,
    required this.right,
  });

  final Widget left;
  final Widget right;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MyResponsive.paddingSymmetric(context, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [left, right],
      ),
    );
  }
}
