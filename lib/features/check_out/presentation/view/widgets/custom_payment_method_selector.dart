import 'package:flutter/material.dart';
import '../../../../../config/enums/payment_method.dart';
import '../../../../../core/localization/l10n/app_localizations.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';

class PaymentMethodSelector extends StatelessWidget {
  const PaymentMethodSelector({
    super.key,
    required this.selectedMethod,
    required this.onChanged,
    required this.onCardSelected,
  });

  final PaymentMethod? selectedMethod;
  final ValueChanged<PaymentMethod> onChanged;
  final VoidCallback onCardSelected;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            local.paymentMethod,
            style: AppTextStyles.medium18(context)
                .copyWith(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          _paymentCard(
            context: context,
            title: local.cashOnDelivery,
            isSelected: selectedMethod == PaymentMethod.cash,
            onTap: () => onChanged(PaymentMethod.cash),
          ),

          const SizedBox(height: 8),

          _paymentCard(
            context: context,
            title: local.creditCard,
            isSelected: selectedMethod == PaymentMethod.card,
            onTap: () {
              onChanged(PaymentMethod.card);
              onCardSelected();
            },
          ),
        ],
      ),
    );
  }

  Widget _paymentCard({
    required BuildContext context,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryColor
                : AppColors.grayLight,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: AppTextStyles.regular16(context)),

            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppColors.primaryColor
                      : AppColors.grayLight,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                child: Container(
                  height: 12,
                  width: 12,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryColor,
                  ),
                ),
              )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}