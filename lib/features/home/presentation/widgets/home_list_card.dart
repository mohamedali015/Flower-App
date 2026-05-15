import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower_app/core/helpers/my_responsive.dart';
import 'package:flower_app/core/localization/l10n/app_localizations.dart';
import 'package:flower_app/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class HomeListCard extends StatelessWidget {
  final String? title;
  final int? price;
  final TextStyle? titleStyle;
  final String? image;

  const HomeListCard({
    super.key,
    this.title,
    this.price,
    this.image,
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Padding(
      padding: MyResponsive.paddingOnly(context, end: 16, top: 16),
      child: SizedBox(
        width: MyResponsive.width(context, value: 130),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: image ?? '',
              height: MyResponsive.height(context, value: 150),
              width: MyResponsive.width(context, value: 130),
              errorWidget: (context, url, error) =>
                  const Center(child: Icon(Icons.error)),
              fit: BoxFit.cover,
            ),

            SizedBox(height: MyResponsive.height(context, value: 5)),
            if (title != null)
              Text(
                title!,
                style: titleStyle ?? AppTextStyles.regular12(context),
                overflow: TextOverflow.ellipsis,
              ),

            if (price != null)
              Text(
                '$price ${local.egp}',
                style: AppTextStyles.medium14(context),
              ),
          ],
        ),
      ),
    );
  }
}
