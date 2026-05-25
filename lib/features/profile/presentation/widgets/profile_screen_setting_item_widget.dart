import 'package:flutter/material.dart';

class ProfileScreenSettingItemWidget extends StatelessWidget {
  const ProfileScreenSettingItemWidget({
    super.key,
    required this.start,
    required this.end,
    required this.onTap,
  });

  final Widget start;
  final Widget end;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isArabic = Directionality.of(context) == TextDirection.rtl;

    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          start,

          end is IconButton ? Transform.flip(flipX: isArabic, child: end) : end,
        ],
      ),
    );
  }
}
