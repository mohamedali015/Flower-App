import 'package:flutter/material.dart';
import '../../../../../core/shared_widgets/svg_wrapper.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../user_address/domain/entities/address.dart';

class CustomDeliveryAddress extends StatelessWidget {
  const CustomDeliveryAddress({
    super.key,
    required this.address,
    required this.onTapEdit,
    required this.isSelected,
  });

  final Address address;
  final VoidCallback? onTapEdit;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryColor : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            title: Row(
              children: [
                Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primaryColor
                          : AppColors.grayDark,
                      width: 2,
                    ),
                  ),
                  child: isSelected
                      ? Center(
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  )
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    address.city ?? '',
                    style: AppTextStyles.medium16(context).copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                address.street ?? '',
                style: AppTextStyles.regular14(context).copyWith(
                  color: AppColors.grayDark,
                ),
              ),
            ),
            trailing: IconButton(
              onPressed: onTapEdit,
              icon: const SvgWrapper(
                path: AppAssets.edit,
                height: 24,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}