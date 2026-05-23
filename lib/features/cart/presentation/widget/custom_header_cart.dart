import 'package:flutter/cupertino.dart';
import '../../../../config/base_state/base_state.dart';
import '../../../../core/helpers/my_responsive.dart';
import '../../../../core/localization/l10n/app_localizations.dart';
import '../../../../core/shared_widgets/svg_wrapper.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../domain/entities/get_cart_entity.dart';

class CustomHeaderCart extends StatelessWidget {
  const CustomHeaderCart({super.key, required this.getCart});
  final BaseState<GetCartEntity>? getCart;

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    return Row(
      children: [
        const SvgWrapper(path: AppAssets.backBtn),
        SizedBox(width: MyResponsive.width(context, value: 8)),
        Text(
          local.cart,
          style: AppTextStyles.medium20(
            context,
          ).copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(width: MyResponsive.width(context, value: 7)),
        Text(
          "( ${getCart?.data?.numOfCartItems} ${local.items})",
          style: AppTextStyles.medium20(
            context,
          ).copyWith(color: AppColors.grayDark),
        ),
      ],
    );
  }
}
